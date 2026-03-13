class RecipeStepsController < ApplicationController
  def index
    matching_recipe_steps = RecipeStep.all

    @list_of_recipe_steps = matching_recipe_steps.order({ :created_at => :desc })

    render({ :template => "recipe_step_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_recipe_steps = RecipeStep.where({ :id => the_id })

    @the_recipe_step = matching_recipe_steps.at(0)

    render({ :template => "recipe_step_templates/show" })
  end

  def create
    the_recipe_step = RecipeStep.new
    the_recipe_step.recipe_id = params.fetch("query_recipe_id")
    the_recipe_step.component_id = params.fetch("query_component_id")
    the_recipe_step.step_number = params.fetch("query_step_number")
    the_recipe_step.instruction = params.fetch("query_instruction")

    if the_recipe_step.valid?
      the_recipe_step.save
      redirect_to("/recipe_steps", { :notice => "Recipe step created successfully." })
    else
      redirect_to("/recipe_steps", { :alert => the_recipe_step.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_recipe_step = RecipeStep.where({ :id => the_id }).at(0)

    the_recipe_step.recipe_id = params.fetch("query_recipe_id")
    the_recipe_step.component_id = params.fetch("query_component_id")
    the_recipe_step.step_number = params.fetch("query_step_number")
    the_recipe_step.instruction = params.fetch("query_instruction")

    if the_recipe_step.valid?
      the_recipe_step.save
      redirect_to("/recipe_steps/#{the_recipe_step.id}", { :notice => "Recipe step updated successfully." } )
    else
      redirect_to("/recipe_steps/#{the_recipe_step.id}", { :alert => the_recipe_step.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_recipe_step = RecipeStep.where({ :id => the_id }).at(0)

    the_recipe_step.destroy

    redirect_to("/recipe_steps", { :notice => "Recipe step deleted successfully." } )
  end
end
