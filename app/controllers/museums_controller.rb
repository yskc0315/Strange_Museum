class MuseumsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]
  before_action :set_museum, only:[:show, :edit, :update]

  def new
    @museum = Museum.new
    @regular_holidays = ["月", "火", "水", "木", "金", "土", "日", "祝", "不定期", "なし", "不明"]
  end

  def create
    museum = Museum.new(params_museum)
    museum.user_id = current_user.id
    museum.status = 1
    museum.save
    redirect_to museum_path(museum.id)
  end

  def show
    @post = Post.new
    @posts = Post.where(museum_id: params[:id])
  end

  def index
    @museums = Museum.all.order(:prefecture)
  end

  def edit
    @regular_holidays = ["月", "火", "水", "木", "金", "土", "日", "祝", "不定期", "なし", "不明"]
  end

  def update
    @museum.user_id = current_user.id
    @museum.status = 2
    @museum.update(params_museum)
    redirect_to museum_path(@museum.id)
  end

  private

  def params_museum
    params.require(:museum).permit(
      :appearance_image, :name, :genre_id, :prefecture, :address, :latitude, :longitude,
      :opening_time, :closing_time, :entrance_fee, :shop, :url, :regular_holiday => []
      )
  end

  def set_museum
    @museum = Museum.find(params[:id])
  end
end
