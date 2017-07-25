class DashboardController < ApplicationController

  def index
    if current_user.try(:admin?)
      @users = User.all
      @notifications = Notification.all
      @monthly_growth = ((User.where("created_at > ?", 1.month.ago).count / User.all.count.to_f) * 100).round
    else
      sign_out(current_user)
      redirect_to "/users/sign_in", notice: "Must be an admin user to login at this dashboard. Please checkout our mobile app for our members."
    end
  end
end
