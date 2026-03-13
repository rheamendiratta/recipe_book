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
end
