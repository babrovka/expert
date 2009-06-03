class OrderMailer < ActionMailer::Base
  include ApplicationHelper

  def confirm(order, sent_at = Time.now)
    subject    "Заказ №#{order.id} принят!"
    recipients order.user.email
    from       'noreply.ekka@gmail.com'
    sent_on    sent_at
    body       :order=>order, :date=>to_russian_date(order.created_at), :name=>order.user.name
  end

  def inform(order, email, sent_at = Time.now)
    subject    "Поступил заказ №#{order.id}!"
    recipients email
    from       'noreply.ekka@gmail.com'
    sent_on    sent_at
    
    body       :order=>order, :date=>to_russian_date(order.created_at)
  end

  def message(message, sent_at = Time.now)
    subject    "Новое сообщение по заказу №#{message.order.id}!"
    recipients message.order.user.email
    from       'noreply.ekka@gmail.com'
    sent_on    sent_at
    body       :message=>message, :order=>message.order, :date=>to_russian_date(message.created_at), :name=>message.order.user.name
  end
end
