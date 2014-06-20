class ProfilesController < ApplicationController
  
  #before_action :find_profile, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user
 
  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def new
     
  end

  def create
    @user = User.find(parmas[:id])
    @profile = @user.profile.create(profile_parmas)
    redirect user_path(@user)
  end

  def edit
  end
 
  def update
  end

  def destroy
  end

  private
  def profile_params
    params.require(:profile).permit(:description)
  end
  
  def find_profile
    @profile = Profile.find(params[:id])
  end

end
