class CreateRecipeComments < ActiveRecord::Migration[8.0]
  def change
    create_table :recipe_comments do |t|
      t.integer :user_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end
