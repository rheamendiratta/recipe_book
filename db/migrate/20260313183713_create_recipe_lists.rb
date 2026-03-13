class CreateRecipeLists < ActiveRecord::Migration[8.0]
  def change
    create_table :recipe_lists do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
