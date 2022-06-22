class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    # @post.post_board_id = 1
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
    authorize @post
  end

  def show
    @post = Post.find(params[:id])
    authorize @post
  end

  # def index
  #   @pagy, @posts = pagy(Post.order(created_at: :desc))
  #   authorize @posts
  #   skip_policy_scope
  # end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
    authorize @post
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
end
