class LikesController < ApplicationController

  def create
    @like = current_user.likes.new(like_params)
    authorize @like
    flash[:notice] = @like.errors.messages unless @like.save

    redirect_to @like.post
  end

  def destroy
    authorize @like
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_to @like.post
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
