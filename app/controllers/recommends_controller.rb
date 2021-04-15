class RecommendsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_museum, only:[:create, :destroy]

  def create
    recommend = current_user.recommends.new(museum_id: @museum.id)
    recommend.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    recommend = current_user.recommends.find_by(museum_id: @museum.id)
    recommend.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_museum
    @museum = Museum.find(params[:museum_id])
  end
end
