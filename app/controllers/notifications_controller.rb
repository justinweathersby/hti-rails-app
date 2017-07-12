class NotificationsController < ApplicationController

  def index
    @notifications = Notification.all
  end

  def show
    @notification = Notification.find(params[:id])
  end

  def new
    @push_notification = Notification.new
    @users = User.all
    # @users = User.where.not('device_token' => nil)
  end

  def edit
  end

  def create
    @push_notification = Notification.new(push_notification_params)
    @push_notification.user_id = current_user.id

    @push_notification.sent_to = params[:tokens]
    @push_notification.sent_to.each do |t|
      device_token = User.find(t).device_token
      @push_notification.tokens.push(device_token) unless device_token.nil?
    end

    respond_to do |format|
      if @push_notification.save
        format.html { redirect_to push_notifications_path, notice: 'Push Notification was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    Notification.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to push_notifications_path, notice: 'Push Notification was successfully destroyed.' }
    end
  end

  private

  def push_notification_params
    params.fetch(:push_notification, {}).permit(:message, :sent_to, :user_id, tokens:[])
  end
end
