class Admin::UsersController < ApplicationController

  def index
    @user = User.all
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
