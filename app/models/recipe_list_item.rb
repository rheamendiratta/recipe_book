class RecipeListItem < ApplicationRecord
  belongs_to :recipe, required: true, class_name: "Recipe", foreign_key: "recipe_id"
  belongs_to :list, required: true, class_name: "RecipeList", foreign_key: "list_id"

  validates :recipe_id, uniqueness: { scope: :list_id }
end
