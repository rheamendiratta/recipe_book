class CreateRecipeBookEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :recipe_book_entries do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.string :entry_type
      t.boolean :has_cooked
      t.integer :star_rating

      t.timestamps
    end
  end
end
