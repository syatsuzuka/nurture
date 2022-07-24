class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_active_knowledge

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    authorize @post

    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    authorize @post
  end

  def edit
    authorize @post
  end

  def update
    authorize @post

    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to knowledge_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :summary, :content, :photo)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_active_knowledge
    @active_knowledge = "class=active"
  end
end
