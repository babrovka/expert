# encoding: utf-8
class PaymentsController < ApplicationController

  before_filter :require_admin

  def new
    order=Order.find(params[:order_id])
    @title="Новый платеж по заказу №#{order.id}"
    @payment=Payment.new(:order_id=>order.id)
  end

  def create
    if params_posted?(:payment)
       order=Order.find(params[:payment][:order_id])
       @payment=Payment.new(params[:payment])
       if @payment.save
          flash[:notice]="Платеж сохранен!"
          redirect_to order_url(@payment.order_id)
       else
          render :action=>:new
       end
    end
  end

  def edit
     @payment=Payment.find(params[:id])
     render :layout=>false
  end

  def update
    if params[:payment]
      @payment=Payment.find(params[:id])
      if @payment.update_attributes(params[:payment])
          flash[:notice]="Платеж сохранен!"
          redirect_to order_url(@payment.order_id)
       else
          flash[:notice]="Ошибка изменения платежа!"
          redirect_to :back
       end
    end
  end

  def destroy
      @payment=Payment.find(params[:id])
         if @payment.destroy
            flash[:notice]="Платеж удален!"
            redirect_to order_url(@payment.order_id)
         else
            flash[:notice]="Ошибка удаления платежа!"
            redirect_to :back
         end
  end

end

