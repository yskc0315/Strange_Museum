class VisitsController < ApplicationController
  before_action :set_museum, only:[:create, :destroy]

  def create
    visit = current_user.visits.new(museum_id: @museum.id)
    visit.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    visit = current_user.visits.find_by(museum_id: @museum.id)
    visit.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_museum
    @museum = Museum.find(params[:museum_id])
  end
end
