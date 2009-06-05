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
      redirect_back_or_default account_url
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
    if current_user.admin?
      @user=User.find(params[:id])
    else
      @user = @current_user
    end
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      if current_user.supervisor?
        @user.admin=params[:user][:admin]
        @user.save
      end
      flash[:notice] = "Изменения сохранены!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  def account
    @title="Личный кабинет"
    @status=params[:status]
    @statuses=Status.all
    if @status=="old"
      conditions='status_id>3'
    else
      conditions='status_id<4'
    end
    @user = @current_user
    @orders=@user.orders.find(:all, :conditions=>conditions)
  end
end
