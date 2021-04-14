class HomesController < ApplicationController
  def top
    @created_museums = Museum.where(status: 1).order(created_at: "DESC")
    @updated_museums = Museum.where(status: 2).order(created_at: "DESC")
  end

  def about
  end

end
