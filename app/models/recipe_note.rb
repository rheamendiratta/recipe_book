class RecipeNote < ApplicationRecord
  belongs_to :recipe, required: true, class_name: "Recipe", foreign_key: "recipe_id"
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"

  validates :note_text, presence: true
end
