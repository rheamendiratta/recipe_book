class RecipeBookController < ApplicationController
  def index
    @entries = current_user.recipe_book_entries.includes(:recipe).order(created_at: :desc)
    @recipes = @entries.map(&:recipe).compact
    @entry_map = @entries.index_by(&:recipe_id)
    render template: "recipe_book_templates/index"
  end

  def search
    @query = params[:query].to_s.strip
    @duration = params[:duration].to_i
    @entries = current_user.recipe_book_entries.includes(:recipe)
    @recipes = @entries.map(&:recipe).compact

    if @query.present?
      @recipes = @recipes.select { |r| r.recipe_ingredients.any? { |i| i.name.to_s.downcase.include?(@query.downcase) } }
    end

    if @duration > 0
      @recipes = @recipes.select { |r| r.total_time_min.present? && r.total_time_min <= @duration }
    end

    @entry_map = current_user.recipe_book_entries.index_by(&:recipe_id)
    render template: "recipe_book_templates/index"
  end
end
