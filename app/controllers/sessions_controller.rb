class SessionsController < ApplicationController
  
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    if user.login.nil?
      session[:return_to] = request.env['omniauth.origin']
      redirect_to new_user_path, :notice => "Please choose a username to complete your registration."
    else
      redirect_to request.env['omniauth.origin'] || root_url, :notice => "Signed in as #{user.login}."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
  
end
