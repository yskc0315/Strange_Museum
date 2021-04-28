class GenresController < ApplicationController
  before_action :if_not_admin

  def create
    @genre = Genre.new(params_genre)
    @genres = Genre.all
    unless @genre.save
      render 'index'
    end
  end

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    @genre = Genre.new
    @genres = Genre.all
  end

  private

  def params_genre
    params.require(:genre).permit(:name)
  end

  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end
end
