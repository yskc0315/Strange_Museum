class ForumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_forum, only:[:show, :destroy, :lock]

  def create
    forum = Forum.new(forum_params)
    forum.user_id = current_user.id
      if    params[:forum][:date] == "undecided"
        forum.when = "未定"
      elsif params[:forum][:date] == "decided"
        forum.when = params[:forum][:when]
      end
    forum.save
    redirect_back(fallback_location: root_path)
  end

  def index
    @forums = Forum.all
    @forum = Forum.new
    @forum.users << current_user
  end

  def show
    if !@forum.users.include?(current_user)
      @forum.users << current_user
    end
    @forum_post = current_user.forum_posts.new
    @forum_posts = ForumPost.where(forum_id: @forum.id).all
  end

  def destroy
    @forum.destroy
    redirect_back(fallback_location: root_path)
  end

  def lock
    if @forum.lock == false
      @forum.lock = true
    else
      @forum.lock = false
    end
    @forum.save
    redirect_back(fallback_location: root_path)
  end

  private

  def forum_params
    params.require(:forum).permit(:title, :body, :where, :when, :user_id => [])
  end

  def forum_post_params
    params.require(:forum_post).permit(:message)
  end

  def set_forum
    @forum = Forum.find(params[:id])
  end
end
