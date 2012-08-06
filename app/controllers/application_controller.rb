# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :current_user_session, :current_user

  before_filter :set_user

  def params_posted?(symbol)
    request.post? and params[symbol]
  end


  def set_user
    unless current_user
      @user=User.new
      @user_session = UserSession.new
    else
      @user=current_user
      @order=Order.new
      @order.messages.build
      5.times {@order.messages[0].documents.build}
      @default_type=OrderType.active.first
    end
  end

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user
      unless current_user
        store_location
        #flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_path
        return false
      end
    end


    def require_admin
      unless current_user && (current_user.admin? || current_user.supervisor?)
        redirect_to :root
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        #flash[:notice] = "You must be logged out to access this page"
        redirect_to :account
        return false
      end
    end

    def store_location
      session[:return_to] = request.url
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end


end

