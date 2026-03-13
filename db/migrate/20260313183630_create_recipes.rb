class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.integer :creator_id
      t.integer :original_recipe_id
      t.string :title
      t.text :description
      t.string :photo_url
      t.string :source_url
      t.string :source_type
      t.integer :base_servings
      t.integer :prep_time_min
      t.integer :cook_time_min
      t.integer :total_time_min
      t.string :diet_type
      t.string :meal_type
      t.float :est_calories_per_serving
      t.float :est_carbs_g_per_serving
      t.float :est_fat_g_per_serving
      t.float :est_protein_g_per_serving
      t.float :est_fibre_g_per_serving
      t.datetime :nutrition_estimated_at

      t.timestamps
    end
  end
end
