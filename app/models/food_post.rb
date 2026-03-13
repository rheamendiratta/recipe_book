class FoodPost < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  belongs_to :recipe, class_name: "Recipe", foreign_key: "recipe_id", optional: true
  has_many :post_comments, class_name: "PostComment", foreign_key: "post_id", dependent: :destroy
  has_many :post_likes, class_name: "PostLike", foreign_key: "post_id", dependent: :destroy

  has_one_attached :photo

  validates :caption, presence: true
end
