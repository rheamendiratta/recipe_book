class PostComment < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  belongs_to :post, required: true, class_name: "FoodPost", foreign_key: "post_id"

  validates :comment_text, presence: true
end
