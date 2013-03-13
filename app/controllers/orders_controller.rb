# encoding: utf-8
require 'spreadsheet'

class OrdersController < ApplicationController
  before_filter :require_user
  before_filter :require_admin, :except => [:new, :create, :show, :download]
  before_filter :find_order
  before_filter :check_ownership, only: :download

  def new
    @title = "Новый заказ"
    @order = Order.new.with_empty_message
    @order.order_type_id = params[:order_type_id].to_i if params[:order_type_id]
    @default_type = @order.order_type || OrderType.active.first
  end

  def create
    if params_posted?(:order)
       @order = Order.new(params[:order])
       @order.user = current_user
       @order.price = @order.order_type.price
       @order.status_id = 1
       @order.messages[0].user = current_user
       if @order.save
          OrderMailer.inform(@order, 'ooo_ekka@mail.ru').deliver
          OrderMailer.confirm(@order).deliver unless @order.user.email.empty?
          flash[:notice]="Заказ создан!"
          redirect_to account_url
       else
          render :action => :new
       end
    end
  end

  def update
    if params[:order]
      if @order.update_attributes(params[:order])
        flash[:notice] = "Статус заказа #{@order.id} изменен!"
      end
    end
    redirect_to orders_path(:status => @order.status_id)
  end

  def index
    scope = Order.scoped.includes(:user, :order_type)

    if params[:status]
      @status = Status.find(params[:status].to_i)
      scope = scope.where(:status_id => @status.id)
    end

    @orders = scope.paginate(:page => params[:page], :per_page => 20)
    @statuses = Status.all
  end

  def show
    @title = "Заказ №#{@order.id}"
    @statuses = Status.all
    @payment = Payment.new(:order_id=>@order.id)
    @delivery = Delivery.new(:order_id=>@order.id)
    if @order.user == current_user || current_user.admin?
      @show_message = params[:new_message]
      @order
      @message = @order.messages.build
      5.times { @message.documents.build }
    else
      redirect_to account_url
    end
  end

  def download
    book = Spreadsheet.open Rails.root.join('public', 'platezh.xls')
    fill_sheet(book.worksheet(0))

    output = StringIO.new 
    book.write output
    send_data output.string, :filename => "platezh.xls", :type =>  "application/vnd.ms-excel"
  end

  def order_payment
    if params[:payment_num] && params[:payment_date] =~ /[0-9]{2}\.[0-9]{2}\.[0-9]{4}/
      @order.order_payment = OrderPayment.new({
        payment_num: params[:payment_num],
        payment_date: format_date_db(params[:payment_date]),
        sum: params[:sum],
        status: params[:status].to_i,
        comment: params[:comment],
      })
      @order.save
      OrderMailer.payment(@order).deliver
    end

    redirect_to @order
  end

  def change_status
     if @order.update_attributes(:status_id => params[:status_id])
       flash[:notice]="Статус заказа #{order.id} изменен!"
     else
       flash[:notice]="Ошибка: Статус заказа #{order.id} не изменен!"
     end
     redirect_to @order
  end

  def update_status
    status = Status.find(params[:order][:status_id])
    if params[:order_id].present?
      Order.where(:id => params[:order_id].values).update_all(:status_id => status.id)
      flash[:notice] = "Статус изменен"
    else
      flash[:notice] = "Не выбрано ни одного заказа"
    end
    redirect_to orders_path(:status => status.id)
  end

  def find_order
    @order = Order.find(params[:id]) if params[:id]
  end

  private
  def check_ownership
    raise 'У вас нет прав на этот заказ' unless current_user.admin || @order.user == current_user
  end

  def fill_sheet(sheet)
    order_date = @order.created_at.strftime('%d/%m/%Y')
    
    row = sheet.row(8)
    row[21] = @order.id
    row[26] = order_date
    row = sheet.row(11)
    row[17] = @order.price
    row = sheet.row(26)
    row[21] = @order.id
    row[26] = order_date
    row = sheet.row(29)
    row[17] = @order.price
  end

end

