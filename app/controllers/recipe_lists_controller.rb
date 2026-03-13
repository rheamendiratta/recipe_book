class RecipeListsController < ApplicationController
  def index
    @lists = current_user.recipe_lists.includes(recipe_list_items: :recipe).order(created_at: :desc)
    render template: "recipe_list_templates/index"
  end

  def show
    @list = RecipeList.find(params[:path_id])
    require_ownership(@list)
    return if performed?
    @items = @list.recipe_list_items.includes(:recipe).order(created_at: :desc)
    @my_book_recipe_ids = current_user.recipe_book_entries.pluck(:recipe_id)
    render template: "recipe_list_templates/show"
  end

  def create
    list = current_user.recipe_lists.new(name: params[:query_name])
    if list.save
      redirect_to "/recipe_lists", notice: "List created."
    else
      redirect_to "/recipe_lists", alert: list.errors.full_messages.to_sentence
    end
  end

  def update
    list = RecipeList.find(params[:path_id])
    require_ownership(list)
    return if performed?
    list.update(name: params[:query_name])
    redirect_to "/recipe_lists/#{list.id}", notice: "List renamed."
  end

  def destroy
    list = RecipeList.find(params[:path_id])
    require_ownership(list)
    return if performed?
    list.destroy
    redirect_to "/recipe_lists", notice: "List deleted."
  end
end
