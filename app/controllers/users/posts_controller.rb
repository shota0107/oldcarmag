class Users::PostsController < ApplicationController
  before_action :set_q, only: [:index, :search]

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save
    redirect_to users_posts_path
  end

  def index
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new

  end

  def edit
    @post = Post.find(params[:id])

  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to users_post_path(post.id)
  end

  def destroy

  end

  def search
    @results = @q.result
  end

  private

  def post_params
    params.require(:post).permit(:name, :introduction, :image, tag_ids: [])
  end

  def set_q
    @q = Post.ransack(params[:q])
  end


end
