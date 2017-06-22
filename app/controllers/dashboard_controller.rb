class DashboardController < ApplicationController

  def index
    @users = User.all
    @notifications = Notification.all
  end

end
