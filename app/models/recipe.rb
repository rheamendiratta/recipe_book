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
end
