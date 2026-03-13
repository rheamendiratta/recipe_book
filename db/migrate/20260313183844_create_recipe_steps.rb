class CreateRecipeSteps < ActiveRecord::Migration[8.0]
  def change
    create_table :recipe_steps do |t|
      t.integer :recipe_id
      t.integer :component_id
      t.integer :step_number
      t.text :instruction

      t.timestamps
    end
  end
end
