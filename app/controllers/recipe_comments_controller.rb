class RecipeCommentsController < ApplicationController
  def create
    recipe = Recipe.find(params[:query_recipe_id])
    # Can comment if it's your recipe, or you're friends with the creator
    unless recipe.creator_id == current_user.id || current_user.friend?(recipe.creator)
      redirect_to "/recipes/#{recipe.id}", alert: "You can only comment on friends' recipes." and return
    end
    comment = recipe.recipe_comments.new(user_id: current_user.id, comment_text: params[:query_comment_text])
    if comment.save
      redirect_to "/recipes/#{recipe.id}", notice: "Comment added."
    else
      redirect_to "/recipes/#{recipe.id}", alert: comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    comment = RecipeComment.find(params[:path_id])
    unless comment.user_id == current_user.id || comment.recipe.creator_id == current_user.id
      redirect_to "/recipes/#{comment.recipe_id}", alert: "Not authorized." and return
    end
    recipe_id = comment.recipe_id
    comment.destroy
    redirect_to "/recipes/#{recipe_id}", notice: "Comment deleted."
  end
end
