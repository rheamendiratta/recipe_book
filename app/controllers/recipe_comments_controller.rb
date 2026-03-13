class RecipeCommentsController < ApplicationController
  def index
    matching_recipe_comments = RecipeComment.all

    @list_of_recipe_comments = matching_recipe_comments.order({ :created_at => :desc })

    render({ :template => "recipe_comment_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_recipe_comments = RecipeComment.where({ :id => the_id })

    @the_recipe_comment = matching_recipe_comments.at(0)

    render({ :template => "recipe_comment_templates/show" })
  end

  def create
    the_recipe_comment = RecipeComment.new
    the_recipe_comment.user_id = params.fetch("query_user_id")
    the_recipe_comment.recipe_id = params.fetch("query_recipe_id")

    if the_recipe_comment.valid?
      the_recipe_comment.save
      redirect_to("/recipe_comments", { :notice => "Recipe comment created successfully." })
    else
      redirect_to("/recipe_comments", { :alert => the_recipe_comment.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_recipe_comment = RecipeComment.where({ :id => the_id }).at(0)

    the_recipe_comment.user_id = params.fetch("query_user_id")
    the_recipe_comment.recipe_id = params.fetch("query_recipe_id")

    if the_recipe_comment.valid?
      the_recipe_comment.save
      redirect_to("/recipe_comments/#{the_recipe_comment.id}", { :notice => "Recipe comment updated successfully." } )
    else
      redirect_to("/recipe_comments/#{the_recipe_comment.id}", { :alert => the_recipe_comment.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_recipe_comment = RecipeComment.where({ :id => the_id }).at(0)

    the_recipe_comment.destroy

    redirect_to("/recipe_comments", { :notice => "Recipe comment deleted successfully." } )
  end
end
