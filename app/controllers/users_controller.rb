class UsersController < ApplicationController
  
 # before_action :authorize, only: [:show] 
  
  before_action :signed_in_user, only: [:show]
  before_action :correct_user,   only: [:show]
  

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver
      sign_in @user
      flash[:success] = "Welcome in Social Network 2014! #{@user.name}"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
  
    def signed_in_user
      unless signed_in?
        flash[:danger] ="Please sign in"
        redirect_to signin_url
      end
      #redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
