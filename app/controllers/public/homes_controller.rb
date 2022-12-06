class Public::HomesController < ApplicationController

  def top
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts.page(params[:page]) : Post.page(params[:page])
  end

end
