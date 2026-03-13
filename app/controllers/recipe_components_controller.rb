class RecipeComponentsController < ApplicationController
  def index
    matching_recipe_components = RecipeComponent.all

    @list_of_recipe_components = matching_recipe_components.order({ :created_at => :desc })

    render({ :template => "recipe_component_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_recipe_components = RecipeComponent.where({ :id => the_id })

    @the_recipe_component = matching_recipe_components.at(0)

    render({ :template => "recipe_component_templates/show" })
  end

  def create
    the_recipe_component = RecipeComponent.new
    the_recipe_component.recipe_id = params.fetch("query_recipe_id")
    the_recipe_component.name = params.fetch("query_name")
    the_recipe_component.sort_order = params.fetch("query_sort_order")

    if the_recipe_component.valid?
      the_recipe_component.save
      redirect_to("/recipe_components", { :notice => "Recipe component created successfully." })
    else
      redirect_to("/recipe_components", { :alert => the_recipe_component.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_recipe_component = RecipeComponent.where({ :id => the_id }).at(0)

    the_recipe_component.recipe_id = params.fetch("query_recipe_id")
    the_recipe_component.name = params.fetch("query_name")
    the_recipe_component.sort_order = params.fetch("query_sort_order")

    if the_recipe_component.valid?
      the_recipe_component.save
      redirect_to("/recipe_components/#{the_recipe_component.id}", { :notice => "Recipe component updated successfully." } )
    else
      redirect_to("/recipe_components/#{the_recipe_component.id}", { :alert => the_recipe_component.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_recipe_component = RecipeComponent.where({ :id => the_id }).at(0)

    the_recipe_component.destroy

    redirect_to("/recipe_components", { :notice => "Recipe component deleted successfully." } )
  end
end
