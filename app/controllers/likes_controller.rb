class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    authorize @like
    flash[:notice] = @like.errors.messages unless @like.save

    redirect_back(fallback_location: posts_path)
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    authorize @like
    like = @like
    like.destroy
    redirect_back(fallback_location: posts_path)

  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
