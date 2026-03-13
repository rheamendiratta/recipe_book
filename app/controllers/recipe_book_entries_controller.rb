class RecipeBookEntriesController < ApplicationController
  def mark_cooked
    entry = RecipeBookEntry.find(params[:path_id])
    require_ownership(entry)
    return if performed?
    entry.mark_cooked!
    redirect_to "/recipes/#{entry.recipe_id}", notice: "Marked as cooked!"
  end

  def rate
    entry = RecipeBookEntry.find(params[:path_id])
    require_ownership(entry)
    return if performed?
    rating = params[:star_rating].to_i
    if (1..5).include?(rating)
      entry.update!(star_rating: rating)
      redirect_to "/recipes/#{entry.recipe_id}", notice: "Rating saved."
    else
      redirect_to "/recipes/#{entry.recipe_id}", alert: "Invalid rating."
    end
  end
end
