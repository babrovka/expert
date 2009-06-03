class MessagesController < ApplicationController

  before_filter :require_user
  
  def new
    @order=Order.find(params[:order_id])
    if @order.user==current_user || current_user.admin?
      @show_message=params[:new_message]
      @message=@order.messages.build
      5.times {@message.documents.build}
    else
      redirect_to account_url
    end
  end

  def create
    if params_posted?(:message)
       order=Order.find(params[:message][:order_id])
       if order.user==current_user || current_user.admin?
        
         @message=Message.new(params[:message])
         @message.user=current_user
         if @message.save 
            OrderMailer.deliver_message(@message) unless order.user.email.empty? || order.user==@message.user
            flash[:notice]="Сообщение сохранено!"
            redirect_to order_url(@message.order_id)
         else
            flash[:notice]="Ошибка создания сообщения!"
            redirect_to :back
         end
       else
          redirect_to account_url
       end
    end
  end

end
