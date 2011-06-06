class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def current_user_login
    unless current_user.login?
      redirect_to new_user_path, :notice => "You must create a username first."
    end
  end
  
  
end
