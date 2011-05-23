class SiteController < ApplicationController

  def index
   @title="Экспертный калькулятор"
  end


  def about
   @title="О проекте"
  end

  def payment
   @title="Как оплатить"
  end


  def contacts
   @title="Контакты"
  end

  def services
   @title="Услуги"
   @services=OrderType.active.all
  end


end

