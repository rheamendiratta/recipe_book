# == Schema Information
#
# Table name: recipes
#
#  id                        :bigint           not null, primary key
#  base_servings             :integer
#  cook_time_min             :integer
#  description               :text
#  diet_type                 :string
#  est_calories_per_serving  :float
#  est_carbs_g_per_serving   :float
#  est_fat_g_per_serving     :float
#  est_fibre_g_per_serving   :float
#  est_protein_g_per_serving :float
#  meal_type                 :string
#  nutrition_estimated_at    :datetime
#  photo_url                 :string
#  prep_time_min             :integer
#  source_type               :string
#  source_url                :string
#  title                     :string
#  total_time_min            :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  creator_id                :integer
#  original_recipe_id        :integer
#
class Recipe < ApplicationRecord

  has_many  :recipe_book_entries, class_name: "RecipeBookEntry", foreign_key: "recipe_id", dependent: :destroy
  has_many  :recipe_notes, class_name: "RecipeNote", foreign_key: "recipe_id", dependent: :destroy
  has_many  :recipe_comments, class_name: "RecipeComment", foreign_key: "recipe_id", dependent: :destroy
  has_many  :recipe_components, class_name: "RecipeComponent", foreign_key: "recipe_id", dependent: :destroy
  has_many  :recipe_ingredients, class_name: "RecipeIngredient", foreign_key: "recipe_id", dependent: :destroy
  has_many  :recipe_list_items, class_name: "RecipeListItem", foreign_key: "recipe_id", dependent: :destroy
  has_many  :recipe_steps, class_name: "RecipeStep", foreign_key: "recipe_id", dependent: :destroy
  has_many  :food_posts, class_name: "FoodPost", foreign_key: "recipe_id", dependent: :nullify
  belongs_to :creator, required: true, class_name: "User", foreign_key: "creator_id", counter_cache: true
end
