class RecipeStep < ApplicationRecord
  belongs_to :recipe, required: true, class_name: "Recipe", foreign_key: "recipe_id"
  belongs_to :component, class_name: "RecipeComponent", foreign_key: "component_id", optional: true

  validates :instruction, presence: true
  validates :step_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
