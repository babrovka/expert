# encoding: utf-8
class MessagesController < ApplicationController

  before_filter :require_user
  before_filter :require_admin, :only=>[:edit, :update, :destroy]
  
  def new
    @title="Новое сообщение"
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
          OrderMailer.message_notification(@message).deliver unless order.user.email.empty? || order.user==@message.user
          flash[:notice] = "Сообщение сохранено!"
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

  def edit
    @title="Редактирование сообщения"
    @message=Message.find(params[:id])
    5.times {@message.documents.build}
    redirect_to order_url(@message.order), :alert => "Только автор комментария может редактировать этот комментрий" unless @message.user.admin?
  end

  def update
    if params[:message]
      @message=Message.find(params[:id])
      if @message.user.admin?      
        if @message.update_attributes(params[:message])
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

  def destroy
    @message=Message.find(params[:id])
    if @message.user.admin?      
      if @message.destroy
        flash[:notice]="Сообщение удалено!"
        redirect_to :back
      else
        flash[:notice]="Ошибка удаления сообщения!"
        redirect_to :back
      end
    end
  end
end
