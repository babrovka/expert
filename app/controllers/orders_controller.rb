class OrdersController < ApplicationController

  before_filter :require_user
  
  def new
     @order=Order.new
     @order.messages.build
     5.times {@order.messages[0].documents.build}
  end

  def create
    if params_posted?(:order)
       @order=Order.new(params[:order])
       @order.user=current_user
       @order.status_id=1
       @order.messages[0].user=current_user
       if @order.save 
          flash[:notice]="Заказ создан!"
          redirect_to account_url
       else
          render :action=>:new
       end

    end
  end
   
end
