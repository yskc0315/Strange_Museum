class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_set, only:[:show, :edit, :update, :withdraw, :back]

  def index
    @users = User.page(params[:page]).per(20)
  end

  def show
    @my_posts       = Post.where(user_id: @user.id).order(id: "DESC")
    @visits        = Visit.where(user_id: current_user.id)
    @museums    = Museum.all.order(:prefecture)
    @forum_users = ForumUser.where(user_id: params[:id])
    @followings  = @user.followings
    @followeds   = @user.followeds
    # 通知関係↓
    @notifications = current_user.passive_notifications.all
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    @created_museums = Museum.where(status: 1).last(5)
    @updated_museums = Museum.where(status: 2).last(5)
    # ここまで
  end

  def edit
  end

  def update
    if @user.update(params_user)
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def withdraw
    @user.update(is_deleted: true)
    unless current_user.admin?
      reset_session
      redirect_to root_path
    end
    @users = User.all
  end

  def back
    @user.update(is_deleted: false)
    @users = User.all
  end

  def sort
    if params[:sort] == "recommend"
      @users = User.all.sort{|a,b| b.recommends.count <=> a.recommends.count}
      @sort = "recommend"
    elsif params[:sort] == "visit"
      @users = User.all.sort{|a,b| b.visits.count <=> a.visits.count}
      @sort = "visitor"
    elsif params[:sort] == "post"
      @users = User.all.sort{|a,b| b.posts.count <=> a.posts.count}
      @sort = "comment"
    elsif params[:sort] == "picture"
      @users = User.all.sort{|a,b| b.post_images.count <=> a.post_images.count}
      @sort = "picture"
    end
  end

  private

  def user_set
    @user = User.find(params[:id])
  end

  def params_user
    params.require(:user).permit(:profile_image, :name, :introduction)
  end
end
