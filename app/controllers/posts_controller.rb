class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    @post = Post.new()
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    # @post.post_board_id = 1
    if @post.save
      redirect_to @post

    else
      render :new
    end
    authorize @post
  end

  def show
    @post = Post.find(params[:id])
    authorize @post
  end

  def index
    @posts = Post.all
    authorize @posts
    skip_policy_scope
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
  end

  def destroy

    @post = Post.find(params[:id])
    authorize @post
    @post.destroy
    redirect_to '/knowledge'
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
