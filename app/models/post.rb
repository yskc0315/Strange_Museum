class Post < ApplicationRecord
  has_many :post_images
  accepts_attachments_for :post_images, attachment: :picture
  has_many :favorites
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :museum


  enum how_to_visit: {電車で: 1, 車で: 2, バスで: 3, その他: 4}
  enum companion: {おひとり: 1, 友達と: 2, 恋人と: 4, 家族と: 5}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_favorite!(current_user)
    # いいね済かどうかを確認
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合に通知を作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # if notification.visitor_id == notification.visited_id
      #   notification.checked = true
      # end
      # 通知を保存
      notification.save if notification.valid?
    end
  end

end
