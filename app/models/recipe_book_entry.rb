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
  belongs_to :recipe, required: true, class_name: "Recipe", foreign_key: "recipe_id"
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"

  ENTRY_TYPES = %w[owned saved duplicated].freeze
  validates :entry_type, inclusion: { in: ENTRY_TYPES }
  validates :star_rating, numericality: { in: 1..5 }, allow_nil: true

  def mark_cooked!
    update!(has_cooked: true)
  end
end
