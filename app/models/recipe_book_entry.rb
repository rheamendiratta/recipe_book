# == Schema Information
#
# Table name: recipe_book_entries
#
#  id          :bigint           not null, primary key
#  entry_type  :string
#  has_cooked  :boolean
#  star_rating :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  recipe_id   :integer
#  user_id     :integer
#
class RecipeBookEntry < ApplicationRecord
end
