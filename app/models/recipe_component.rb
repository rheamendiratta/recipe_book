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
end
