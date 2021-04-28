class RecommendsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_museum, only:[:create, :destroy]

  def create
    recommend = current_user.recommends.new(museum_id: @museum.id)
    recommend.save
  end

  def destroy
    recommend = current_user.recommends.find_by(museum_id: @museum.id)
    recommend.destroy
  end

  private

  def set_museum
    @museum = Museum.find(params[:museum_id])
  end
end
