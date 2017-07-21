class UsersController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update]
  before_action :authenticate_admin

  def index
    @users = User.all
  end

  def new
  end

  def show
  end

  private
    def authenticate_admin
      unless current_user.try(:admin?)
        render json: {
          status: :unathorized
        }.to_json
      end
    end

    def find_user
      @user = User.find(params[:id])
    end

end
