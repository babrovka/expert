class SiteController < ApplicationController

  def index
   @title="Экспертный калькулятор"
  end


  def about
   @title="О проекте"
  end

  def contacts
   @title="Контакты"
  end

end

