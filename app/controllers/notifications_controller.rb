class NotificationsController < ApplicationController

  def index
    @notifications = Notification.all
  end

  def new
    @push_notification = Notification.new
    @users = User.all
  end

  def show
    @notification = Notification.find(params[:id])
  end

end
