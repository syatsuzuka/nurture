class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new

  end

  def create
  end

  def show
  end

  def index
    @posts = Post.all
    authorize @posts
    skip_policy_scope
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
