class Museum < ApplicationRecord

# ↓バリデーション
  # validates :appearance_image_id, presence: true
  validates :name, presence: true
  validates :genre_id, presence: true
  validates :opening_time, presence: true
  validates :closing_time, presence: true
  validates :regular_holiday, presence: true
  validates :prefecture, presence: true
  validates :address, presence: true
  validates :entrance_fee, presence: true
# ↑バリデーション
  attachment :appearance_image

# アソシエーション
  has_many :recommends, dependent: :destroy
  has_many :recommend_users, through: :recommends, source: :user
  has_many :visits, dependent: :destroy
  has_many :visit_users, through: :visits, source: :user
  has_many :posts, dependent: :destroy
  has_many :post_images, through: :posts
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :genre

  geocoded_by :location
  after_validation :geocode, if: :address_changed?

# regular_holidayの保存前に/[\[\]\"]/を""に変換
  before_save do
    self.regular_holiday.gsub!(/[\[\]\"]/, "") if attribute_present?("regular_holiday")
  end

# 県名選択時のenum
  enum prefecture: {
      "--県名を選択--": 0,
     北海道: 1, 青森県: 2, 岩手県: 3, 宮城県: 4, 秋田県: 5, 山形県: 6, 福島県: 7,
     茨城県: 8, 栃木県: 9, 群馬県: 10, 埼玉県: 11, 千葉県: 12, 東京都: 13, 神奈川県: 14,
     新潟県: 15, 富山県: 16, 石川県: 17, 福井県: 18, 山梨県: 19, 長野県: 20,
     岐阜県: 21, 静岡県: 22, 愛知県: 23, 三重県: 24,
     滋賀県: 25, 京都府: 26, 大阪府: 27, 兵庫県: 28, 奈良県: 29, 和歌山県: 30,
     鳥取県: 31, 島根県: 32, 岡山県: 33, 広島県: 34, 山口県: 35,
     徳島県: 36, 香川県: 37, 愛媛県: 38, 高知県: 39,
     福岡県: 40, 佐賀県: 41, 長崎県: 42, 熊本県: 43, 大分県: 44, 宮崎県: 45, 鹿児島県: 46, 沖縄県: 47
  }

  def location
    "%s %s"%([self.prefecture, self.address])
  end


  def recommended_by?(user)
    recommends.where(user_id: user.id).exists?
  end

  def visited_by?(user)
    visits.where(user_id: user.id).exists?
  end

  def posted_by(user)
    posts.where(user_id: user.id)
  end

  def self.looks(searches, words)
    if searches == "perfect_match"
      @museum = Museum.where("name LIKE ?", "#{words}")
    elsif searches == "partial_match"
      @museum = Museum.where("name LIKE ?", "%#{words}%")
    end
  end

end