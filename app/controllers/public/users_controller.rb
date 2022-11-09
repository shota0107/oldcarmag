class Public::UsersController < ApplicationController
  before_action :not_permmited_guest_user,

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to '/top'
  end

   private

  def user_params
    params.require(:user).permit(:name, )
  end

  def not_permmited_guest_user
    return if current_user.is_guest?
    redirect_to root_path
  end

end
