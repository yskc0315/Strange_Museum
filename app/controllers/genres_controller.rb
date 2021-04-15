class GenresController < ApplicationController
  before_action :authenticate_user!

  def create
    genre = Genre.new(params_genre)
    genre.save
    redirect_to genres_path
  end

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_to genres_path
  end

  private

  def params_genre
    params.require(:genre).permit(:name)
  end
end
