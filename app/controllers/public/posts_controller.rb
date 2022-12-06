class Public::PostsController < ApplicationController
  before_action :set_q, only: [:index, :search]
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
    flash[:notice] = "投稿しました。"
    redirect_to posts_path
    else
       render :new
    end
  end

  def index
    @posts = params[:tag_id].blank? ? Post.all : Tag.find(params[:tag_id]).posts
    @posts = Post.page(params[:page])
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
    flash[:notice] = "変更が完了しました。"
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def search
    @results = @q.result
  end

  private

  def ensure_user
    @posts = current_user.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to post_path(post.id) unless @post
  end

  def post_params
    params.require(:post).permit(:name, :introduction, :image, tag_ids: [])
  end

  def set_q
    @q = Post.ransack(params[:q])
  end
end
