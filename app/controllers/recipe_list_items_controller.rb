class RecipeListItemsController < ApplicationController
  def index
    matching_recipe_list_items = RecipeListItem.all

    @list_of_recipe_list_items = matching_recipe_list_items.order({ :created_at => :desc })

    render({ :template => "recipe_list_item_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_recipe_list_items = RecipeListItem.where({ :id => the_id })

    @the_recipe_list_item = matching_recipe_list_items.at(0)

    render({ :template => "recipe_list_item_templates/show" })
  end

  def create
    the_recipe_list_item = RecipeListItem.new
    the_recipe_list_item.list_id = params.fetch("query_list_id")
    the_recipe_list_item.recipe_id = params.fetch("query_recipe_id")

    if the_recipe_list_item.valid?
      the_recipe_list_item.save
      redirect_to("/recipe_list_items", { :notice => "Recipe list item created successfully." })
    else
      redirect_to("/recipe_list_items", { :alert => the_recipe_list_item.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_recipe_list_item = RecipeListItem.where({ :id => the_id }).at(0)

    the_recipe_list_item.list_id = params.fetch("query_list_id")
    the_recipe_list_item.recipe_id = params.fetch("query_recipe_id")

    if the_recipe_list_item.valid?
      the_recipe_list_item.save
      redirect_to("/recipe_list_items/#{the_recipe_list_item.id}", { :notice => "Recipe list item updated successfully." } )
    else
      redirect_to("/recipe_list_items/#{the_recipe_list_item.id}", { :alert => the_recipe_list_item.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_recipe_list_item = RecipeListItem.where({ :id => the_id }).at(0)

    the_recipe_list_item.destroy

    redirect_to("/recipe_list_items", { :notice => "Recipe list item deleted successfully." } )
  end
end
