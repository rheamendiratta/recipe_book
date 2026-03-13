# == Schema Information
#
# Table name: recipe_steps
#
#  id           :bigint           not null, primary key
#  instruction  :text
#  step_number  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  component_id :integer
#  recipe_id    :integer
#
class RecipeStep < ApplicationRecord
end
