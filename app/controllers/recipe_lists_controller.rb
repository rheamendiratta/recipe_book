class RecipeListsController < ApplicationController
  def index
    matching_recipe_lists = RecipeList.all

    @list_of_recipe_lists = matching_recipe_lists.order({ :created_at => :desc })

    render({ :template => "recipe_list_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_recipe_lists = RecipeList.where({ :id => the_id })

    @the_recipe_list = matching_recipe_lists.at(0)

    render({ :template => "recipe_list_templates/show" })
  end

  def create
    the_recipe_list = RecipeList.new
    the_recipe_list.user_id = params.fetch("query_user_id")
    the_recipe_list.name = params.fetch("query_name")

    if the_recipe_list.valid?
      the_recipe_list.save
      redirect_to("/recipe_lists", { :notice => "Recipe list created successfully." })
    else
      redirect_to("/recipe_lists", { :alert => the_recipe_list.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_recipe_list = RecipeList.where({ :id => the_id }).at(0)

    the_recipe_list.user_id = params.fetch("query_user_id")
    the_recipe_list.name = params.fetch("query_name")

    if the_recipe_list.valid?
      the_recipe_list.save
      redirect_to("/recipe_lists/#{the_recipe_list.id}", { :notice => "Recipe list updated successfully." } )
    else
      redirect_to("/recipe_lists/#{the_recipe_list.id}", { :alert => the_recipe_list.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_recipe_list = RecipeList.where({ :id => the_id }).at(0)

    the_recipe_list.destroy

    redirect_to("/recipe_lists", { :notice => "Recipe list deleted successfully." } )
  end
end
