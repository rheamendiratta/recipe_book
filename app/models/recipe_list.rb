# == Schema Information
#
# Table name: recipe_lists
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class RecipeList < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  has_many :recipe_list_items, class_name: "RecipeListItem", foreign_key: "list_id", dependent: :destroy
  has_many :recipes, through: :recipe_list_items

  validates :name, presence: true
end
