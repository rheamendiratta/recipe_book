# == Schema Information
#
# Table name: recipe_ingredients
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  component_id :integer
#  recipe_id    :integer
#
class RecipeIngredient < ApplicationRecord

  belongs_to :recipe, required: true, class_name: "Recipe", foreign_key: "recipe_id"
  belongs_to :component, class_name: "RecipeComponent", foreign_key: "component_id"
  
end
