class OrdersController < ApplicationController

  before_filter :require_user
  before_filter :require_admin, :except=>[:new, :create, :show]

  def new
     @order=Order.new
     @order.messages.build
     5.times {@order.messages[0].documents.build}
  end

  def create
    if params_posted?(:order)
       @order=Order.new(params[:order])
       @order.user=current_user
       @order.price=@order.order_type.price
       @order.status_id=1
       @order.messages[0].user=current_user
       if @order.save 
          OrderMailer.deliver_inform(@order, 'ooo_ekka@mail.ru')
          OrderMailer.deliver_confirm(@order) unless @order.user.email.empty?
          flash[:notice]="Заказ создан!"
          redirect_to account_url
       else
          render :action=>:new
       end

    end
  end
   

  def index
     if params[:status]
       @status=Status.find(params[:status].to_i)
     else
       @status=Status.find(1)
     end
    @orders=Order.paginate(:conditions=>['status_id=?',@status.id], :page=>params[:page], :per_page=>20)
    @statuses=Status.all
    @title="Заказы: #{@status.menu_name}"
  end

  def show
    @order=Order.find(params[:id])
    if @order.user==current_user || current_user.admin?
      @show_message=params[:new_message]
      @message=@order.messages.build
      5.times {@message.documents.build}
    else
      redirect_to account_url
    end
  end

  def change_status
     order=Order.find(params[:id])
     status=Status.find(params[:status])
     order.status=status
     if order.save
       flash[:notice]="Статус заказа #{order.id} изменен!"
     else
       flash[:notice]="Ошибка: Статус заказа #{order.id} не изменен!"
     end
     redirect_to :back     
  end
end
