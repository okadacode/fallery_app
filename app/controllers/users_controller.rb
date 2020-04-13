class UsersController < ApplicationController
  def show
    @user = User.find_by!(name: params[:name])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.icon = "icon.png"
    @user.header = "header.jpeg"
  end
end
