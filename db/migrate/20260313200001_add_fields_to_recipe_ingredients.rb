class AddFieldsToRecipeIngredients < ActiveRecord::Migration[8.0]
  def change
    add_column :recipe_ingredients, :name, :string
    add_column :recipe_ingredients, :quantity, :string
    add_column :recipe_ingredients, :unit, :string
    add_column :recipe_ingredients, :sort_order, :integer
  end
end
