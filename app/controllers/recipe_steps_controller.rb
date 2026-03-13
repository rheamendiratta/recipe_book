class RecipeStepsController < ApplicationController
  def create
    recipe = Recipe.find(params[:query_recipe_id])
    unless recipe.creator_id == current_user.id
      redirect_to "/recipes/#{recipe.id}", alert: "Not authorized." and return
    end
    step = recipe.recipe_steps.new(
      step_number: params[:query_step_number] || recipe.recipe_steps.count + 1,
      instruction: params[:query_instruction],
      component_id: params[:query_component_id].presence
    )
    if step.save
      redirect_to "/recipes/#{recipe.id}", notice: "Step added."
    else
      redirect_to "/recipes/#{recipe.id}", alert: step.errors.full_messages.to_sentence
    end
  end

  def update
    step = RecipeStep.find(params[:path_id])
    unless step.recipe.creator_id == current_user.id
      redirect_to "/recipes/#{step.recipe_id}", alert: "Not authorized." and return
    end
    step.update(step_number: params[:query_step_number], instruction: params[:query_instruction])
    redirect_to "/recipes/#{step.recipe_id}", notice: "Step updated."
  end

  def destroy
    step = RecipeStep.find(params[:path_id])
    unless step.recipe.creator_id == current_user.id
      redirect_to "/recipes/#{step.recipe_id}", alert: "Not authorized." and return
    end
    recipe_id = step.recipe_id
    step.destroy
    redirect_to "/recipes/#{recipe_id}", notice: "Step removed."
  end
end
