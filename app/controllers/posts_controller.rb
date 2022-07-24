class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_active_knowledge

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    # @post.post_board_id = 1
    authorize @post

    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    authorize @post
  end

=begin
  def index
    @pagy, @posts = pagy(Post.order(created_at: :desc))
    authorize @posts
    skip_policy_scope
  end
=end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post

    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post
    @post.destroy
    redirect_to '/knowledge'
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :photo)
  end

  def set_active_knowledge
    @active_knowledge = "class=active"
  end
end
