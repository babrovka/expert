class OrdersController < ApplicationController

  before_filter :require_user
  
  def new
     @order=Order.new
     @order.messages.build
  end

  def create
    if params_posted?(:order)
       @order=Order.new(params[:order])
       @order.user=current_user
       @order.status="new"
       message=@order.messages[0]
       params.keys.each do |key|
          if key.to_s[0..3]=="file"
             id=key.split('_')[1].to_i+1
             att=message.attachments.new
             att.file=params["file_#{id-1}"]
             @order.errors.add("Файл #{id}", "некорректный путь или размер файла") unless att.valid?
          end
       end

       if @order.save
          flash[:notice]="Заказ создан!"
          redirect_to account_url
       else
          render :action=>:new
       end

    end
  end
   
end
