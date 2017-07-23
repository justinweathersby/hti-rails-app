class DashboardController < ApplicationController
  before_action :authenticate_admin

  def index
    @users = User.all
    @notifications = Notification.all
    @monthly_growth = (User.where("created_at > ?", 1.month.ago).count / User.all.count.to_f) * 100
  end

  def authenticate_admin
    unless current_user.try(:admin?)
      render json: {
        status: :unathorized
      }.to_json
    end
  end

end
