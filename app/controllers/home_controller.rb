class HomeController < ApplicationController
  def index
=begin   
   if current_user
      redirect_to user_path(current_user.id)
    end
=end
    @time = Time.now
    @posts= Post.all
  end
end
