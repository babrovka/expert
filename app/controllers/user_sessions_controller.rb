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
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Вы вышли из системы!"
    redirect_back_or_default login_url
  end
end
