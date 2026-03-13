class RecipeComponentsController < ApplicationController
  def create
    recipe = Recipe.find(params[:query_recipe_id])
    unless recipe.creator_id == current_user.id
      redirect_to "/recipes/#{recipe.id}", alert: "Not authorized." and return
    end
    comp = recipe.recipe_components.new(name: params[:query_name], sort_order: params[:query_sort_order] || recipe.recipe_components.count + 1)
    if comp.save
      redirect_to "/recipes/#{recipe.id}", notice: "Component added."
    else
      redirect_to "/recipes/#{recipe.id}", alert: comp.errors.full_messages.to_sentence
    end
  end

  def update
    comp = RecipeComponent.find(params[:path_id])
    unless comp.recipe.creator_id == current_user.id
      redirect_to "/recipes/#{comp.recipe_id}", alert: "Not authorized." and return
    end
    comp.update(name: params[:query_name], sort_order: params[:query_sort_order])
    redirect_to "/recipes/#{comp.recipe_id}", notice: "Component updated."
  end

  def destroy
    comp = RecipeComponent.find(params[:path_id])
    unless comp.recipe.creator_id == current_user.id
      redirect_to "/recipes/#{comp.recipe_id}", alert: "Not authorized." and return
    end
    recipe_id = comp.recipe_id
    comp.destroy
    redirect_to "/recipes/#{recipe_id}", notice: "Component removed."
  end
end
