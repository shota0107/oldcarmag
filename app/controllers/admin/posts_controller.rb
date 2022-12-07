class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!, only: [:show,:new]
  before_action :set_q, only: [:index]

  def index
    @posts = Post.page(params[:page])
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

  def set_q
    @q = Post.ransack(params[:q])
  end

end
