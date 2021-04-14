class PostImage < ApplicationRecord
  belongs_to :post
  attachment :picture
end
