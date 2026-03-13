class CreateRecipeNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipe_notes do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.text :note_text

      t.timestamps
    end
  end
end
