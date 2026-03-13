class RecipeIngredient < ApplicationRecord
  belongs_to :recipe, required: true, class_name: "Recipe", foreign_key: "recipe_id"
  belongs_to :component, class_name: "RecipeComponent", foreign_key: "component_id", optional: true

  validates :name, presence: true

  def display_quantity
    [quantity, unit, name].compact.join(" ")
  end
end
