class CommentsController < ApplicationController
  def new
  end

  def create
  end

  def index
    @comments = Comment.all
  end

  def edit
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
  end
end
