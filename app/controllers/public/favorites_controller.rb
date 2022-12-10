class Public::FavoritesController < ApplicationController

  def index
    @favorite_posts = current_user.favorite_posts
  end

  def create
    favorite = current_user.favorites.build(post_id: params[:post_id])
    if favorite.save
      flash[:notice] = "いいねしました。"
      redirect_to post_path(params[:post_id])
    else
      render :posts_show
    end
  end

  def destroy
    favorite = current_user.favorites.find_by(post_id: params[:post_id])
    favorite.destroy
    flash[:notice] = "いいねを取り消しました。"
    redirect_to post_path(params[:post_id])
  end

  private

  def favorite_params
    params.require(:favorite).permit(:user_id)
  end

  def not_permmited_guest_user
    return unless current_user.is_guest?
    redirect_to root_path
  end

end
