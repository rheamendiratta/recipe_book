class CreateRecipeListItems < ActiveRecord::Migration[8.0]
  def change
    create_table :recipe_list_items do |t|
      t.integer :list_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end
