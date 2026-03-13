# == Schema Information
#
# Table name: recipe_list_items
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  list_id    :integer
#  recipe_id  :integer
#
class RecipeListItem < ApplicationRecord

  belongs_to :recipe, required: true, class_name: "Recipe", foreign_key: "recipe_id"
  belongs_to :list, required: true, class_name: "RecipeList", foreign_key: "list_id"
  
end
