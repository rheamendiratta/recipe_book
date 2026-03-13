class RecipeIngredientsController < ApplicationController
  def create
    recipe = Recipe.find(params[:query_recipe_id])
    unless recipe.creator_id == current_user.id
      redirect_to "/recipes/#{recipe.id}", alert: "Not authorized." and return
    end
    ing = recipe.recipe_ingredients.new(
      name: params[:query_name],
      quantity: params[:query_quantity],
      unit: params[:query_unit],
      component_id: params[:query_component_id].presence,
      sort_order: recipe.recipe_ingredients.count + 1
    )
    if ing.save
      redirect_to "/recipes/#{recipe.id}", notice: "Ingredient added."
    else
      redirect_to "/recipes/#{recipe.id}", alert: ing.errors.full_messages.to_sentence
    end
  end

  def update
    ing = RecipeIngredient.find(params[:path_id])
    unless ing.recipe.creator_id == current_user.id
      redirect_to "/recipes/#{ing.recipe_id}", alert: "Not authorized." and return
    end
    ing.update(name: params[:query_name], quantity: params[:query_quantity], unit: params[:query_unit])
    redirect_to "/recipes/#{ing.recipe_id}", notice: "Ingredient updated."
  end

  def destroy
    ing = RecipeIngredient.find(params[:path_id])
    unless ing.recipe.creator_id == current_user.id
      redirect_to "/recipes/#{ing.recipe_id}", alert: "Not authorized." and return
    end
    recipe_id = ing.recipe_id
    ing.destroy
    redirect_to "/recipes/#{recipe_id}", notice: "Ingredient removed."
  end
end
