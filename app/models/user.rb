class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  attachment :picture

  has_many :active_relations, class_name: "Relation", foreign_key: :following_id, dependent: :destroy
  has_many :followings, through: :active_relations, source: :followed
  has_many :passive_relations, class_name: "Relation", foreign_key: :followed_id, dependent: :destroy
  has_many :followeds, through: :passive_relations, source: :following
  has_many :recommends
  has_many :visits
  has_many :favorites
  has_many :posts
  has_many :museums
  has_many :active_notifications, class_name: "Notification", foreign_key: :visitor_id, dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: :visited_id, dependent: :destroy

  def followed_by?(user)
    passive_relations.find_by(following_id: user.id).present?
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

end
