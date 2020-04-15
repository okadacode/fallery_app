class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

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
                                   :password, :password_confirmation,
                                   :icon, :header)
    end

    def logged_in_user
      unless logged_in?
        flash[:notice] = "ログインが必要なページです"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find_by(name: params[:name])
      redirect_to(root_url) unless @user == current_user
    end
end
