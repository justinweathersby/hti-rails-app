class UsersController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def new
  end

  # def show
  # end

  private

    def find_user
      @user = User.find(params[:id])
    end

end
