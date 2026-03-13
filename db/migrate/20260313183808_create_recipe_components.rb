class CreateRecipeComponents < ActiveRecord::Migration[8.0]
  def change
    create_table :recipe_components do |t|
      t.integer :recipe_id
      t.string :name
      t.integer :sort_order

      t.timestamps
    end
  end
end
