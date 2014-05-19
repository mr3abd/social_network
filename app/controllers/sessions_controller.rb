class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    sign_in user
    #session[:user_id] = user.id
    flash[:success] = "Welcome in Social Network 2014 #{user.name}"
    redirect_to user
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    #session[:user_id] = nil
    #redirect_to root_url
  end
  
end
