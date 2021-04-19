class RelationsController < ApplicationController
  before_action :authenticate_user!

  def create
    follow = current_user.active_relations.build(followed_id: params[:user_id])
    follow.save
    user = User.find(params[:user_id])
    user.create_notification_follow!(current_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    follow = current_user.active_relations.find_by(followed_id: params[:user_id])
    follow.destroy
    redirect_back(fallback_location: root_path)
  end
end
