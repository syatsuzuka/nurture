class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to @post

    authorize @comment
  end

  def index
    @comments = @post.comments
  end

  def edit
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to @post
  end
end

private

def comment_params
  params.require(:comment).permit(:content)
end
