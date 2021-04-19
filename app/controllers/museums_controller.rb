class MuseumsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]
  before_action :set_museum, only:[:show, :edit, :update, :destroy]

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

  def destroy
    @museum.destroy
    redirect_to museums_path
  end

  def sort
    if params[:sort] == "prefecture"
      @museums = Museum.all.order(:prefecture)
      @sort = "prefecture"
    elsif params[:sort] == "recommend"
      @museums = Museum.all.sort{|a,b| b.recommend_users.count <=> a.recommend_users.count}
      @sort = "recommend"
    elsif params[:sort] == "visitor"
      @museums = Museum.all.sort{|a,b| b.visit_users.count <=> a.visit_users.count}
      @sort = "visitor"
    elsif params[:sort] == "comment"
      @museums = Museum.all.sort{|a,b| b.posts.count <=> a.posts.count}
      @sort = "comment"
    elsif params[:sort] == "picture"
      @museums = Museum.all.sort{|a,b| b.post_images.count <=> a.post_images.count}
      @sort = "picture"
    end
  end

  def map
    @museums = Museum.all.order(:prefecture)
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
