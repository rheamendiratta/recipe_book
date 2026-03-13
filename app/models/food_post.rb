# == Schema Information
#
# Table name: food_posts
#
#  id         :bigint           not null, primary key
#  caption    :text
#  photo_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :integer
#  user_id    :integer
#
class FoodPost < ApplicationRecord

  belongs_to :recipe, class_name: "Recipe", foreign_key: "recipe_id"
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  has_many  :post_comments, class_name: "PostComment", foreign_key: "post_id", dependent: :destroy
  has_many  :post_likes, class_name: "PostLike", foreign_key: "post_id", dependent: :destroy
  
end
