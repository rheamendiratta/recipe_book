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
end
