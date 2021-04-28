class HomesController < ApplicationController
  def top
    @created_museums = Museum.where(status: 1).order(created_at: "DESC").last(7)
    @post_images = PostImage.order("RANDOM()").limit(5)
    render :layout => 'top'
  end

  def about
  end

end
