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

  belongs_to :recipe, required: true, class_name: "Recipe", foreign_key: "recipe_id"
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  
end
