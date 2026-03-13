# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  display_name           :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  profile_photo_url      :string
#  recipes_count          :integer
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many  :recipes, class_name: "Recipe", foreign_key: "creator_id", dependent: :destroy
  has_many  :sent_friend_requests, class_name: "Friendship", foreign_key: "requester_id", dependent: :destroy
  has_many  :received_friend_requests, class_name: "Friendship", foreign_key: "addressee_id", dependent: :destroy
  has_many  :recipe_lists, class_name: "RecipeList", foreign_key: "user_id", dependent: :destroy
  has_many  :recipe_book_entries, class_name: "RecipeBookEntry", foreign_key: "user_id", dependent: :destroy
  has_many  :recipe_notes, class_name: "RecipeNote", foreign_key: "user_id", dependent: :destroy
  has_many  :recipe_comments, class_name: "RecipeComment", foreign_key: "user_id", dependent: :destroy
  has_many  :food_posts, class_name: "FoodPost", foreign_key: "user_id", dependent: :destroy
  has_many  :post_comments, class_name: "PostComment", foreign_key: "user_id", dependent: :destroy
  has_many  :post_likes, class_name: "PostLike", foreign_key: "user_id", dependent: :destroy
end
