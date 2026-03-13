class RecipeNotesController < ApplicationController
  def index
    matching_recipe_notes = RecipeNote.all

    @list_of_recipe_notes = matching_recipe_notes.order({ :created_at => :desc })

    render({ :template => "recipe_note_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_recipe_notes = RecipeNote.where({ :id => the_id })

    @the_recipe_note = matching_recipe_notes.at(0)

    render({ :template => "recipe_note_templates/show" })
  end

  def create
    the_recipe_note = RecipeNote.new
    the_recipe_note.user_id = params.fetch("query_user_id")
    the_recipe_note.recipe_id = params.fetch("query_recipe_id")
    the_recipe_note.note_text = params.fetch("query_note_text")

    if the_recipe_note.valid?
      the_recipe_note.save
      redirect_to("/recipe_notes", { :notice => "Recipe note created successfully." })
    else
      redirect_to("/recipe_notes", { :alert => the_recipe_note.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_recipe_note = RecipeNote.where({ :id => the_id }).at(0)

    the_recipe_note.user_id = params.fetch("query_user_id")
    the_recipe_note.recipe_id = params.fetch("query_recipe_id")
    the_recipe_note.note_text = params.fetch("query_note_text")

    if the_recipe_note.valid?
      the_recipe_note.save
      redirect_to("/recipe_notes/#{the_recipe_note.id}", { :notice => "Recipe note updated successfully." } )
    else
      redirect_to("/recipe_notes/#{the_recipe_note.id}", { :alert => the_recipe_note.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_recipe_note = RecipeNote.where({ :id => the_id }).at(0)

    the_recipe_note.destroy

    redirect_to("/recipe_notes", { :notice => "Recipe note deleted successfully." } )
  end
end
