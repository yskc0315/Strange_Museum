class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_set, only:[:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @posts      = Post.where(user_id: @user.id)
    @museums    = Museum.all.order(:prefecture)
    @followings = @user.followings
    @followeds  = @user.followeds
    # 通知関係↓
    @notifications = current_user.passive_notifications.all
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    @created_museums = Museum.where(status: 1).order(created_at: "DESC")
    @updated_museums = Museum.where(status: 1).order(created_at: "DESC")
    # ここまで
  end

  def edit
  end

  def update
    @user.update(params_user)
    redirect_to user_path(current_user)
  end

  private

  def user_set
    @user = User.find(params[:id])
  end

  def params_user
    params.require(:user).permit(:profile_image, :name, :introduction)
  end
end
