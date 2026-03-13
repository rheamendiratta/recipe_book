# == Schema Information
#
# Table name: recipe_comments
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :integer
#  user_id    :integer
#
class RecipeComment < ApplicationRecord
end
