# == Schema Information
#
# Table name: recipe_notes
#
#  id         :bigint           not null, primary key
#  note_text  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :integer
#  user_id    :integer
#
class RecipeNote < ApplicationRecord
end
