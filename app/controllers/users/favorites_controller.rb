class Users::FavoritesController < ApplicationController

  def index
    @favorite_posts = current_user.favorite_posts
  end

  def create
    favorite = current_user.favorites.build(post_id: params[:post_id])
    if favorite.save
      redirect_to users_post_path(post.id)
    else
      render :show

    end
  end

  def destroy
    favorite = current_user.favorite.find_by(post_id: params[:post_id])
    favorite.destroy
    redirect_to users_post_path(post.id)
  end

  private

  def favorite_params
    params.require(:favorite).permit(:user_id)
  end

end
