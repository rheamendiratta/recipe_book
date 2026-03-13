# == Schema Information
#
# Table name: recipe_components
#
#  id         :bigint           not null, primary key
#  name       :string
#  sort_order :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :integer
#
class RecipeComponent < ApplicationRecord

  belongs_to :recipe, required: true, class_name: "Recipe", foreign_key: "recipe_id"
  has_many  :recipe_ingredients, class_name: "RecipeIngredient", foreign_key: "component_id", dependent: :nullify
  has_many  :recipe_steps, class_name: "RecipeStep", foreign_key: "component_id", dependent: :nullify
  
end
