class Relation < ApplicationRecord
  belongs_to :following, class_name: "User"
  belongs_to :followed, class_name: "User"
end