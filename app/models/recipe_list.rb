class RecipeList < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  has_many :recipe_list_items, class_name: "RecipeListItem", foreign_key: "list_id", dependent: :destroy
  has_many :recipes, through: :recipe_list_items

  validates :name, presence: true
end
