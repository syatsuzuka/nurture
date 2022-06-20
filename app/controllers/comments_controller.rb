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
    @comments = Comment.all
  end

  def edit
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
  end
end

private

def comment_params
  params.require(:comment).permit(:content)
end
