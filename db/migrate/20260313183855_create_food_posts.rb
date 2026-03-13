class CreateFoodPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :food_posts do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.string :photo_url
      t.text :caption

      t.timestamps
    end
  end
end
