class Admin::DashboardController < ApplicationController
  layout 'admin'

  def index
    @time = Time.now
  end

end
