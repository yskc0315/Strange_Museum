class Genre < ApplicationRecord
# ↓バリデーション
  validates :name, presence: true
# ↑バリデーション
  has_many :museums
end
