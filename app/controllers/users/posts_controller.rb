class Users::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.new
    post.save
    redirect_to '/top'
  end
  def list_params
    params.require(:post).permit(:title, :introduction)
  end
end
