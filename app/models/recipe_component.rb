class RecipeComponent < ApplicationRecord
  belongs_to :recipe, required: true, class_name: "Recipe", foreign_key: "recipe_id"
  has_many :recipe_ingredients, class_name: "RecipeIngredient", foreign_key: "component_id", dependent: :nullify
  has_many :recipe_steps, class_name: "RecipeStep", foreign_key: "component_id", dependent: :nullify

  validates :name, presence: true
end
