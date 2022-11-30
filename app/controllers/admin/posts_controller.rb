class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!, only: [:show,:new]
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:name, :introduction, :image)
  end

end
