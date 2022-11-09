class Public::CommentsController < ApplicationController
  before_action :not_permmited_guest_user,

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(params[:post_id])
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def not_permmited_guest_user
    return if current_user.is_guest?

    redirect_to root_path
  end
end
