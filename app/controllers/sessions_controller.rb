class SessionsController < ApplicationController
  
  def create
    auth = request.env["omniauth.auth"]
    user = User.from_omniauth(auth)
    session[:user_id] = user.id
    session[:credentials] = auth["credentials"]
    redirect_to root_url
    
    # render :json => auth
  end

  def destroy
    session[:user_id] = nil
    session[:credentials] = nil
    redirect_to root_url
  end
end
