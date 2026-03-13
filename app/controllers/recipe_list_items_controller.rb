class RecipeListItemsController < ApplicationController
  def create
    list = RecipeList.find(params[:path_id])
    require_ownership(list)
    return if performed?
    item = list.recipe_list_items.new(recipe_id: params[:recipe_id])
    if item.save
      redirect_back fallback_location: "/recipe_lists/#{list.id}", notice: "Recipe added to list."
    else
      redirect_back fallback_location: "/recipe_lists/#{list.id}", alert: "Recipe already in this list."
    end
  end

  def destroy
    item = RecipeListItem.find(params[:path_id])
    require_ownership(item.list)
    return if performed?
    list_id = item.list_id
    item.destroy
    redirect_to "/recipe_lists/#{list_id}", notice: "Recipe removed from list."
  end
end
