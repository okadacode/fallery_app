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

  def edit
    @user = User.find_by(name: params[:name])
  end

  def update
    @user = User.find_by(name: params[:name])
    if @user.update_attributes(user_params)
      flash[:success] = "保存に成功しました"
      redirect_to "/#{@user.name}"
    else
      render "edit"
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :nickname,
                                   :password, :password_confirmation)
    end
end
