class CommentsController < ApplicationController
  before_action :set_post, only: %i[create destroy]
  before_action :set_comment, only: %i[destroy]

  def index
    @comments = @post.comments
  end

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    authorize @comment

    @comment.save
    redirect_to post_path(@post)
  end

  def destroy
    authorize @comment

    @comment.destroy
    redirect_to post_path(@post)
  end
end

private

def comment_params
  params.require(:comment).permit(:content)
end

def set_post
  @post = Post.find(params[:post_id])
end

def set_comment
  @comment = Comment.find(params[:id])
end
