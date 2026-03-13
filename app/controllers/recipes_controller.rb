class RecipesController < ApplicationController
  def index
    matching_recipes = Recipe.all

    @list_of_recipes = matching_recipes.order({ :created_at => :desc })

    render({ :template => "recipe_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_recipes = Recipe.where({ :id => the_id })

    @the_recipe = matching_recipes.at(0)

    render({ :template => "recipe_templates/show" })
  end

  def create
    the_recipe = Recipe.new
    the_recipe.creator_id = params.fetch("query_creator_id")
    the_recipe.original_recipe_id = params.fetch("query_original_recipe_id")
    the_recipe.title = params.fetch("query_title")
    the_recipe.description = params.fetch("query_description")
    the_recipe.photo_url = params.fetch("query_photo_url")
    the_recipe.source_url = params.fetch("query_source_url")
    the_recipe.source_type = params.fetch("query_source_type")
    the_recipe.base_servings = params.fetch("query_base_servings")
    the_recipe.prep_time_min = params.fetch("query_prep_time_min")
    the_recipe.cook_time_min = params.fetch("query_cook_time_min")
    the_recipe.total_time_min = params.fetch("query_total_time_min")
    the_recipe.diet_type = params.fetch("query_diet_type")
    the_recipe.meal_type = params.fetch("query_meal_type")
    the_recipe.est_calories_per_serving = params.fetch("query_est_calories_per_serving")
    the_recipe.est_carbs_g_per_serving = params.fetch("query_est_carbs_g_per_serving")
    the_recipe.est_fat_g_per_serving = params.fetch("query_est_fat_g_per_serving")
    the_recipe.est_protein_g_per_serving = params.fetch("query_est_protein_g_per_serving")
    the_recipe.est_fibre_g_per_serving = params.fetch("query_est_fibre_g_per_serving")
    the_recipe.nutrition_estimated_at = params.fetch("query_nutrition_estimated_at")

    if the_recipe.valid?
      the_recipe.save
      redirect_to("/recipes", { :notice => "Recipe created successfully." })
    else
      redirect_to("/recipes", { :alert => the_recipe.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_recipe = Recipe.where({ :id => the_id }).at(0)

    the_recipe.creator_id = params.fetch("query_creator_id")
    the_recipe.original_recipe_id = params.fetch("query_original_recipe_id")
    the_recipe.title = params.fetch("query_title")
    the_recipe.description = params.fetch("query_description")
    the_recipe.photo_url = params.fetch("query_photo_url")
    the_recipe.source_url = params.fetch("query_source_url")
    the_recipe.source_type = params.fetch("query_source_type")
    the_recipe.base_servings = params.fetch("query_base_servings")
    the_recipe.prep_time_min = params.fetch("query_prep_time_min")
    the_recipe.cook_time_min = params.fetch("query_cook_time_min")
    the_recipe.total_time_min = params.fetch("query_total_time_min")
    the_recipe.diet_type = params.fetch("query_diet_type")
    the_recipe.meal_type = params.fetch("query_meal_type")
    the_recipe.est_calories_per_serving = params.fetch("query_est_calories_per_serving")
    the_recipe.est_carbs_g_per_serving = params.fetch("query_est_carbs_g_per_serving")
    the_recipe.est_fat_g_per_serving = params.fetch("query_est_fat_g_per_serving")
    the_recipe.est_protein_g_per_serving = params.fetch("query_est_protein_g_per_serving")
    the_recipe.est_fibre_g_per_serving = params.fetch("query_est_fibre_g_per_serving")
    the_recipe.nutrition_estimated_at = params.fetch("query_nutrition_estimated_at")

    if the_recipe.valid?
      the_recipe.save
      redirect_to("/recipes/#{the_recipe.id}", { :notice => "Recipe updated successfully." } )
    else
      redirect_to("/recipes/#{the_recipe.id}", { :alert => the_recipe.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_recipe = Recipe.where({ :id => the_id }).at(0)

    the_recipe.destroy

    redirect_to("/recipes", { :notice => "Recipe deleted successfully." } )
  end
end
