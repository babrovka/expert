class SiteController < ApplicationController

  def index
   @title="Главная"
  end


  def about
   @title="О проекте"
  end

  def contacts
   @title="Контакты"
  end

end
