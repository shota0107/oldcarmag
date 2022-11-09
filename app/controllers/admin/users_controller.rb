class Admin::UsersController < ApplicationController

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
   @user = User.find(params[:id])
  end

  def update
      @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(params[:id]), notice: "会員情報を変更しました"
    else
      render "edit"
    end
  end

  def destroy
    if @user = User.find(params[:id]).destroy
      redirect_to root_path, notice: "退会しました"
    else
      redirect_to "/", notice: "エラー"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

end
