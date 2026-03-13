class RecipesController < ApplicationController
  before_action :load_recipe, only: [:show, :update, :destroy, :cook, :duplicate, :save_to_book, :estimate_nutrition]
  before_action :require_creator, only: [:update, :destroy]

  def new
    render template: "recipe_templates/new"
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.creator_id = current_user.id
    @recipe.source_type = "manual" if @recipe.source_url.blank?

    if @recipe.save
      save_ingredients_and_steps(@recipe, params)
      redirect_to "/recipes/#{@recipe.id}", notice: "Recipe created successfully."
    else
      @errors = @recipe.errors.full_messages
      render template: "recipe_templates/new"
    end
  end

  def import_form
    render template: "recipe_templates/import"
  end

  def import
    url = params[:url].to_s.strip
    if url.blank?
      redirect_to "/recipes/import", alert: "Please enter a URL."
      return
    end

    data = RecipeImportService.new(url).call
    if data.nil?
      redirect_to "/recipes/import", alert: "Could not parse recipe from that URL. Please try entering it manually."
      return
    end

    @recipe = Recipe.new(
      creator_id: current_user.id,
      title: data[:title],
      description: data[:description],
      source_url: data[:source_url] || url,
      source_type: "url",
      prep_time_min: data[:prep_time_min],
      cook_time_min: data[:cook_time_min],
      total_time_min: data[:total_time_min],
      base_servings: data[:base_servings],
      photo_url: data[:photo_url],
      meal_type: data[:meal_type],
      diet_type: data[:diet_type]
    )

    if @recipe.save
      Array(data[:ingredients]).each_with_index do |ing, i|
        @recipe.recipe_ingredients.create(
          name: ing[:name] || ing["name"],
          quantity: ing[:quantity] || ing["quantity"],
          unit: ing[:unit] || ing["unit"],
          sort_order: i + 1
        )
      end
      Array(data[:steps]).each do |step|
        @recipe.recipe_steps.create(
          step_number: step[:step_number] || step["step_number"],
          instruction: step[:instruction] || step["instruction"]
        )
      end
      NutritionService.new(@recipe).estimate!
      redirect_to "/recipes/#{@recipe.id}", notice: "Recipe imported successfully!"
    else
      redirect_to "/recipes/import", alert: @recipe.errors.full_messages.to_sentence
    end
  end

  def show
    @entry = RecipeBookEntry.find_by(user_id: current_user.id, recipe_id: @recipe.id)
    @notes = @recipe.recipe_notes.where(user_id: current_user.id).order(created_at: :desc)
    @comments = @recipe.recipe_comments.includes(:user).order(created_at: :desc)
    @components = @recipe.recipe_components.includes(:recipe_ingredients, :recipe_steps)
    @loose_ingredients = @recipe.recipe_ingredients.where(component_id: nil)
    @loose_steps = @recipe.recipe_steps.where(component_id: nil)
    @lists = current_user.recipe_lists
    @in_book = @entry.present?
    render template: "recipe_templates/show"
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to "/recipes/#{@recipe.id}", notice: "Recipe updated."
    else
      @errors = @recipe.errors.full_messages
      render template: "recipe_templates/show"
    end
  end

  def destroy
    @recipe.destroy
    redirect_to "/my_book", notice: "Recipe deleted."
  end

  def cook
    @recipe = Recipe.find(params[:path_id])
    @serving_size = (params[:servings] || @recipe.base_servings || 1).to_f
    @base_servings = (@recipe.base_servings || 1).to_f
    @ratio = @base_servings > 0 ? @serving_size / @base_servings : 1.0
    @components = @recipe.recipe_components.includes(:recipe_ingredients, :recipe_steps)
    @loose_ingredients = @recipe.recipe_ingredients.where(component_id: nil)
    @loose_steps = @recipe.recipe_steps.where(component_id: nil)
    render template: "recipe_templates/cook"
  end

  def duplicate
    new_recipe = @recipe.duplicate_for(current_user, entry_type: "duplicated")
    redirect_to "/recipes/#{new_recipe.id}", notice: "Recipe duplicated to your book. You can now edit your version."
  end

  def save_to_book
    @recipe.save_to_book_for(current_user)
    redirect_to "/recipes/#{@recipe.id}", notice: "Recipe saved to your book."
  end

  def estimate_nutrition
    require_creator
    return if performed?
    success = NutritionService.new(@recipe).estimate!
    if success
      redirect_to "/recipes/#{@recipe.id}", notice: "Nutrition estimated successfully."
    else
      redirect_to "/recipes/#{@recipe.id}", alert: "Could not estimate nutrition. Make sure the recipe has ingredients."
    end
  end

  private

  def load_recipe
    @recipe = Recipe.find(params[:path_id])
  end

  def require_creator
    unless @recipe.creator_id == current_user.id
      redirect_to "/recipes/#{@recipe.id}", alert: "Only the recipe creator can do that."
    end
  end

  def recipe_params
    params.permit(:query_title, :query_description, :query_source_url, :query_photo_url,
                  :query_base_servings, :query_prep_time_min, :query_cook_time_min,
                  :query_total_time_min, :query_diet_type, :query_meal_type, :photo)
          .transform_keys { |k| k.sub("query_", "") }
  end

  def save_ingredients_and_steps(recipe, params)
    ingredient_names = params.select { |k, _| k.start_with?("ingredient_name_") }
    ingredient_names.each do |key, name|
      next if name.blank?
      idx = key.split("_").last
      recipe.recipe_ingredients.create(
        name: name,
        quantity: params["ingredient_qty_#{idx}"],
        unit: params["ingredient_unit_#{idx}"],
        sort_order: idx.to_i
      )
    end

    step_instructions = params.select { |k, _| k.start_with?("step_instruction_") }
    step_instructions.each do |key, instruction|
      next if instruction.blank?
      idx = key.split("_").last
      recipe.recipe_steps.create(step_number: idx.to_i, instruction: instruction)
    end
  end
end
