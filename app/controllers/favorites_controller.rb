class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only:[:create, :destroy]

  def create
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
    @post.create_notification_favorite!(current_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  # def set_post
  #   @post = Post.find(params[:post_id])
  # end
end
