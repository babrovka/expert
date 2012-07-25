# encoding: utf-8
class UserSessionsController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

 def new
    @title="Вход в систему"
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Вы вошли в систему!"
      if @user_session.user.admin?
        redirect_back_or_default orders_url(:status=>1)
      else
        redirect_back_or_default account_url
      end
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Вы вышли из системы!"
    redirect_to :root
  end
end

