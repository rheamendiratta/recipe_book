class RecipeIngredientsController < ApplicationController
  def index
    matching_recipe_ingredients = RecipeIngredient.all

    @list_of_recipe_ingredients = matching_recipe_ingredients.order({ :created_at => :desc })

    render({ :template => "recipe_ingredient_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_recipe_ingredients = RecipeIngredient.where({ :id => the_id })

    @the_recipe_ingredient = matching_recipe_ingredients.at(0)

    render({ :template => "recipe_ingredient_templates/show" })
  end

  def create
    the_recipe_ingredient = RecipeIngredient.new
    the_recipe_ingredient.recipe_id = params.fetch("query_recipe_id")
    the_recipe_ingredient.component_id = params.fetch("query_component_id")

    if the_recipe_ingredient.valid?
      the_recipe_ingredient.save
      redirect_to("/recipe_ingredients", { :notice => "Recipe ingredient created successfully." })
    else
      redirect_to("/recipe_ingredients", { :alert => the_recipe_ingredient.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_recipe_ingredient = RecipeIngredient.where({ :id => the_id }).at(0)

    the_recipe_ingredient.recipe_id = params.fetch("query_recipe_id")
    the_recipe_ingredient.component_id = params.fetch("query_component_id")

    if the_recipe_ingredient.valid?
      the_recipe_ingredient.save
      redirect_to("/recipe_ingredients/#{the_recipe_ingredient.id}", { :notice => "Recipe ingredient updated successfully." } )
    else
      redirect_to("/recipe_ingredients/#{the_recipe_ingredient.id}", { :alert => the_recipe_ingredient.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_recipe_ingredient = RecipeIngredient.where({ :id => the_id }).at(0)

    the_recipe_ingredient.destroy

    redirect_to("/recipe_ingredients", { :notice => "Recipe ingredient deleted successfully." } )
  end
end
