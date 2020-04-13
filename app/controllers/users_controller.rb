class UsersController < ApplicationController
  def show
    @user = User.find_by!(name: params[:name])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # @user.icon = "icon.png"
    # @user.header = "header.jpeg"
    if @user.save

    else
      render "new"
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :nickname,
                                   :password, :password_confirmation)
    end
end
