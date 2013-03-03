# encoding: utf-8
class SiteController < ApplicationController

  def index
   @title = "Экспертный калькулятор"
  end


  def about
   @title = "Идея проекта"
  end
  
  def howto
   @title = "Как это работает"
  end
  
  def pravila_photo
   @title = "Правила фотографирования"
  end

  def payment
   @title = "Как оплатить"
  end


  def contacts
   @title = "Контакты"
  end
  
  def documents
   @title = "Нормативные документы"
  end

  def services
   @services = OrderType.active.all
  end


end

