# encoding: utf-8
class OrderMailer < ActionMailer::Base
  default :from => "noreply.ekka@gmail.com"
  helper :application
  include ApplicationHelper

  def confirm(order)
    @order  = order
    @date   = to_russian_date(order.created_at)
    @name   = order.user.name

    mail(:to => order.user.email, :subject => "Заказ №#{order.id} принят!")
  end


  def inform(order, email)
    @order  = order
    @date   = to_russian_date(order.created_at)

    mail(:to => email, :subject => "Поступил заказ №#{order.id}!")
  end


  def delivery(order_delivery, email, sent_at = Time.now)
    @delivery = order_delivery
    @date     = to_russian_date(order_delivery.created_at)

    mail(:to => email, :subject => "Запрос на доставку по заказу №#{order_delivery.order_id}!")
  end


  def message_notification(message, sent_at = Time.now)
    @message  = message
    @order    = message.order
    @date     = to_russian_date(message.created_at)
    @name     = message.order.user.name

    mail(:to => message.order.user.email, :subject => "Новое сообщение по заказу №#{message.order.id}!")
  end


  def password_reset_instructions(user)
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)
    mail(:to => user.email, :subject => "Восстановление пароля")
  end
end
