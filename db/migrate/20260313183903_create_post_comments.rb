class CreatePostComments < ActiveRecord::Migration[8.0]
  def change
    create_table :post_comments do |t|
      t.integer :post_id
      t.integer :user_id
      t.text :comment_text

      t.timestamps
    end
  end
end
