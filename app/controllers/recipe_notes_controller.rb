class RecipeNotesController < ApplicationController
  def create
    note = RecipeNote.new(
      recipe_id: params[:query_recipe_id],
      user_id: current_user.id,
      note_text: params[:query_note_text]
    )
    if note.save
      redirect_to "/recipes/#{note.recipe_id}", notice: "Note added."
    else
      redirect_to "/recipes/#{params[:query_recipe_id]}", alert: note.errors.full_messages.to_sentence
    end
  end

  def update
    note = RecipeNote.find(params[:path_id])
    require_ownership(note)
    return if performed?
    note.update(note_text: params[:query_note_text])
    redirect_to "/recipes/#{note.recipe_id}", notice: "Note updated."
  end

  def destroy
    note = RecipeNote.find(params[:path_id])
    require_ownership(note)
    return if performed?
    recipe_id = note.recipe_id
    note.destroy
    redirect_to "/recipes/#{recipe_id}", notice: "Note deleted."
  end
end
