class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_uri
  helper_method :current_user
  
  def check_uri
    redirect_to request.protocol + "www." + request.host_with_port + request.request_uri if !/^www/.match(request.host) if Rails.env == 'production'
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def current_user_login
    if current_user.login.nil?
      redirect_to new_user_path, :notice => "You must create a username first."
    end
  end
  
  
end
