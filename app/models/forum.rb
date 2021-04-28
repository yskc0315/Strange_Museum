class Forum < ApplicationRecord
  belongs_to :user
  has_many :forum_users, dependent: :destroy
  has_many :users, through: :forum_users
  has_many :forum_posts, dependent: :destroy
  accepts_nested_attributes_for :forum_users

  def membered?(current_user)
    forum_users.where(user_id: current_user.id).exists?
  end
end
