class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes, class_name: "Recipe", foreign_key: "creator_id", dependent: :destroy
  has_many :sent_friend_requests, class_name: "Friendship", foreign_key: "requester_id", dependent: :destroy
  has_many :received_friend_requests, class_name: "Friendship", foreign_key: "addressee_id", dependent: :destroy
  has_many :recipe_lists, class_name: "RecipeList", foreign_key: "user_id", dependent: :destroy
  has_many :recipe_book_entries, class_name: "RecipeBookEntry", foreign_key: "user_id", dependent: :destroy
  has_many :recipe_notes, class_name: "RecipeNote", foreign_key: "user_id", dependent: :destroy
  has_many :recipe_comments, class_name: "RecipeComment", foreign_key: "user_id", dependent: :destroy
  has_many :food_posts, class_name: "FoodPost", foreign_key: "user_id", dependent: :destroy
  has_many :post_comments, class_name: "PostComment", foreign_key: "user_id", dependent: :destroy
  has_many :post_likes, class_name: "PostLike", foreign_key: "user_id", dependent: :destroy

  has_one_attached :profile_photo

  def display(fallback = "User")
    display_name.presence || email.split("@").first
  end

  def friends
    accepted_requester_ids = sent_friend_requests.accepted.pluck(:addressee_id)
    accepted_addressee_ids = received_friend_requests.accepted.pluck(:requester_id)
    User.where(id: accepted_requester_ids + accepted_addressee_ids)
  end

  def friend?(other_user)
    friends.include?(other_user)
  end

  def friendship_with(other_user)
    sent_friend_requests.where(addressee_id: other_user.id).first ||
      received_friend_requests.where(requester_id: other_user.id).first
  end

  def book_recipes
    recipe_book_entries.includes(:recipe).map(&:recipe)
  end
end
