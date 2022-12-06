class Public::UsersController < ApplicationController
  before_action :not_permmited_guest_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "変更が完了しました。"
    redirect_to user_path(@user.id)
    else
      render :edit
    end
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
    if current_user.is_guest?
      redirect_to root_path, alert: "ゲストユーザーはそのページを表示することが出来ません"
    end
  end

end
