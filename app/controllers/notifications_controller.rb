class NotificationsController < ApplicationController

  before_action :authenticate_admin

  def index
    @notifications = Notification.all
  end

  def show
    @notification = Notification.find(params[:id])
  end

  def new
    @notification = Notification.new
    @users = User.all
    # @users = User.where.not('device_token' => nil)
  end

  def edit
  end

  def create
    @users = User.all

    @notification = Notification.new(notification_params)
    @notification.user_id = current_user.id

    @notification.sent_to = params[:tokens]

    if @notification.sent_to.present?
      @notification.sent_to.each do |t|
        device_token = @users.find(t).device_token
        @notification.tokens.push(device_token) unless device_token.nil?
      end

      respond_to do |format|
        if @notification.save
          format.html { redirect_to root_path, notice: 'Push Notification was successfully created.' }
        else
          format.html { render :new }
        end
      end

    else
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Error: Please select at least one user to send a push notification.' }
      end
    end
  end

  def destroy
    Notification.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Push Notification was successfully destroyed.' }
    end
  end

  private

  def notification_params
    params.fetch(:notification, {}).permit(:message, :sent_to, :user_id, tokens:[])
  end

  def authenticate_admin
    unless current_user.try(:admin?)
      render json: {
        status: :unathorized
      }.to_json
    end
  end
end
