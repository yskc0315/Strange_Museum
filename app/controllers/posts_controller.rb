class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_museum, only:[:create, :edit, :update, :destroy]

  def create
    post = @museum.posts.build(params_post)
    post.user_id = current_user.id
    post.save
    redirect_back(fallback_location: root_path)
  end

  def edit
    @post = @museum.posts.find(params[:id])
  end

  def update
    post = @museum.posts.find(params[:id])
    post.update(params_post)
    redirect_to museum_path(@museum.id)
  end

  def destroy
    post = @museum.posts.find(params[:id])
    post.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def params_post
    params.require(:post).permit(:title, :body, :how_to_visit, :companion, :post_images_pictures => [])
  end

  def set_museum
    @museum = Museum.find(params[:museum_id])
  end

end
