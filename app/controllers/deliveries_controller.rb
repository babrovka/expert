class DeliveriesController < ApplicationController

  before_filter :require_user
  before_filter :require_admin, :only=>[:edit, :update, :destroy]

  def new
    @order=Order.find(params[:order_id])
    @title="Запрос на доставку документов по заказу №#{@order.id}"
    if @order.user==current_user || current_user.admin?
      @delivery=Delivery.new(:order_id=>@order.id)
    else
      redirect_to account_url
    end
  end

  def create
    if params_posted?(:delivery)
       order=Order.find(params[:delivery][:order_id])
       if order.user==current_user || current_user.admin?
         @delivery=Delivery.new(params[:delivery])
         if @delivery.save 
            OrderMailer.deliver_delivery(@delivery, 'ooo_ekka@mail.ru')
            flash[:notice]="Запрос сохранен!"
            redirect_to order_url(@delivery.order_id)
         else
            render :action=>:new
         end
       else
          redirect_to account_url
       end
    end
  end

  def edit
     @title="Редактирование запроса"
     @delivery=Delivery.find(params[:id])
  end

  def update
    if params[:delivery]
      @delivery=Delivery.find(params[:id])
      if @delivery.update_attributes(params[:delivery])
          flash[:notice]="Запрос сохранено!"
          redirect_to order_url(@delivery.order_id)
       else
          flash[:notice]="Ошибка создания запроса!"
          redirect_to :back
       end
    end
  end

  def destroy
      @delivery=Delivery.find(params[:id])
         if @delivery.destroy
            flash[:notice]="Запрос удален!"
            redirect_to order_url(@delivery.order_id)
         else
            flash[:notice]="Ошибка удаления запроса!"
            redirect_to :back
         end
  end

end  


