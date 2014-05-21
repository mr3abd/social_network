class HomeController < ApplicationController
  def index
    if current_user
      redirect_to user_path(current_user.id)
    end
    @time = Time.now
  end
end
