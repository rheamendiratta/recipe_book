class RecipeBookEntriesController < ApplicationController
  def index
    matching_recipe_book_entries = RecipeBookEntry.all

    @list_of_recipe_book_entries = matching_recipe_book_entries.order({ :created_at => :desc })

    render({ :template => "recipe_book_entry_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_recipe_book_entries = RecipeBookEntry.where({ :id => the_id })

    @the_recipe_book_entry = matching_recipe_book_entries.at(0)

    render({ :template => "recipe_book_entry_templates/show" })
  end

  def create
    the_recipe_book_entry = RecipeBookEntry.new
    the_recipe_book_entry.user_id = params.fetch("query_user_id")
    the_recipe_book_entry.recipe_id = params.fetch("query_recipe_id")
    the_recipe_book_entry.entry_type = params.fetch("query_entry_type")
    the_recipe_book_entry.has_cooked = params.fetch("query_has_cooked")
    the_recipe_book_entry.star_rating = params.fetch("query_star_rating")

    if the_recipe_book_entry.valid?
      the_recipe_book_entry.save
      redirect_to("/recipe_book_entries", { :notice => "Recipe book entry created successfully." })
    else
      redirect_to("/recipe_book_entries", { :alert => the_recipe_book_entry.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_recipe_book_entry = RecipeBookEntry.where({ :id => the_id }).at(0)

    the_recipe_book_entry.user_id = params.fetch("query_user_id")
    the_recipe_book_entry.recipe_id = params.fetch("query_recipe_id")
    the_recipe_book_entry.entry_type = params.fetch("query_entry_type")
    the_recipe_book_entry.has_cooked = params.fetch("query_has_cooked")
    the_recipe_book_entry.star_rating = params.fetch("query_star_rating")

    if the_recipe_book_entry.valid?
      the_recipe_book_entry.save
      redirect_to("/recipe_book_entries/#{the_recipe_book_entry.id}", { :notice => "Recipe book entry updated successfully." } )
    else
      redirect_to("/recipe_book_entries/#{the_recipe_book_entry.id}", { :alert => the_recipe_book_entry.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_recipe_book_entry = RecipeBookEntry.where({ :id => the_id }).at(0)

    the_recipe_book_entry.destroy

    redirect_to("/recipe_book_entries", { :notice => "Recipe book entry deleted successfully." } )
  end
end
