class UsersController < ApplicationController
  def show
    @user = User.find_by(name: params[:name])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Falleryにようこそ！"
      redirect_to "/#{@user.name}"
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
