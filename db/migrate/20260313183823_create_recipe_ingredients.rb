class CreateRecipeIngredients < ActiveRecord::Migration[8.0]
  def change
    create_table :recipe_ingredients do |t|
      t.integer :recipe_id
      t.integer :component_id

      t.timestamps
    end
  end
end
