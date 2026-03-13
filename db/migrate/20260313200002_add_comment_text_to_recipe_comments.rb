class AddCommentTextToRecipeComments < ActiveRecord::Migration[8.0]
  def change
    add_column :recipe_comments, :comment_text, :text
  end
end
