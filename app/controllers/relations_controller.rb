class RelationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only:[:create, :destroy]

  def create
    follow = current_user.active_relations.build(followed_id: params[:user_id])
    follow.save
    @user.create_notification_follow!(current_user)
    @followings  = @user.followings
    @followeds   = @user.followeds
  end

  def destroy
    follow = current_user.active_relations.find_by(followed_id: params[:user_id])
    follow.destroy
    @followings  = @user.followings
    @followeds   = @user.followeds
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
