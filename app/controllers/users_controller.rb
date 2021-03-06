# encoding: utf-8
class UsersController < ApplicationController

 before_filter :require_no_user, :only => [:new, :create]
 before_filter :require_user, :only => [:account, :edit, :update]
 before_filter :require_admin, :only => [:index]

  def new
    @title="Регистрация"

    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Ваш аккаунт создан!"
      redirect_back_or_default '/services'
    else
      render :action => :new
    end
  end


  def index
    @title="Пользователи"
    @users=User.paginate(:page=>params[:page], :per_page=>20)
  end

  def show
    @user = User.find(params[:id])
  end


  def edit
    @title="Настройка пользователя"
    if current_user.supervisor?
      @user=User.find(params[:id])
    else
      @user = @current_user
    end
    render :layout=>false
  end

  def update
    if current_user.supervisor?
      @user=User.find(params[:id])
    else
      @user= @current_user
    end

    if @user.update_attributes(params[:user])
      @user.update_attribute(:admin, params[:user][:admin]) if current_user.supervisor?
      flash[:notice] = "Изменения сохранены!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  def account
    @title    = "Личный кабинет"
    @status   = params[:status]
    @statuses = Status.all
    @user     = @current_user
    @orders   = @user.orders.where(@status == "old" ? 'status_id > 6' : 'status_id < 7').includes(:status, :order_type).all
  end
end

