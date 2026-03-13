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
