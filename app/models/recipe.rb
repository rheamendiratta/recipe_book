# == Schema Information
#
# Table name: recipes
#
#  id                        :bigint           not null, primary key
#  base_servings             :integer
#  cook_time_min             :integer
#  description               :text
#  diet_type                 :string
#  est_calories_per_serving  :float
#  est_carbs_g_per_serving   :float
#  est_fat_g_per_serving     :float
#  est_fibre_g_per_serving   :float
#  est_protein_g_per_serving :float
#  meal_type                 :string
#  nutrition_estimated_at    :datetime
#  photo_url                 :string
#  prep_time_min             :integer
#  source_type               :string
#  source_url                :string
#  title                     :string
#  total_time_min            :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  creator_id                :integer
#  original_recipe_id        :integer
#
class Recipe < ApplicationRecord
  belongs_to :creator, required: true, class_name: "User", foreign_key: "creator_id", counter_cache: true
  belongs_to :original_recipe, class_name: "Recipe", foreign_key: "original_recipe_id", optional: true

  has_many :recipe_book_entries, class_name: "RecipeBookEntry", foreign_key: "recipe_id", dependent: :destroy
  has_many :recipe_notes, class_name: "RecipeNote", foreign_key: "recipe_id", dependent: :destroy
  has_many :recipe_comments, class_name: "RecipeComment", foreign_key: "recipe_id", dependent: :destroy
  has_many :recipe_components, -> { order(:sort_order) }, class_name: "RecipeComponent", foreign_key: "recipe_id", dependent: :destroy
  has_many :recipe_ingredients, -> { order(:sort_order) }, class_name: "RecipeIngredient", foreign_key: "recipe_id", dependent: :destroy
  has_many :recipe_list_items, class_name: "RecipeListItem", foreign_key: "recipe_id", dependent: :destroy
  has_many :recipe_steps, -> { order(:step_number) }, class_name: "RecipeStep", foreign_key: "recipe_id", dependent: :destroy
  has_many :food_posts, class_name: "FoodPost", foreign_key: "recipe_id", dependent: :nullify
  has_many :duplicates, class_name: "Recipe", foreign_key: "original_recipe_id"

  has_one_attached :photo

  DIET_TYPES = %w[vegetarian non_vegetarian eggetarian].freeze
  MEAL_TYPES = %w[breakfast main snack dessert soup salad drink appetizer side spread homemade_staple].freeze

  validates :title, presence: true
  validates :diet_type, inclusion: { in: DIET_TYPES }, allow_nil: true
  validates :meal_type, inclusion: { in: MEAL_TYPES }, allow_nil: true

  after_create :create_owner_book_entry

  scope :by_ingredient, ->(name) {
    joins(:recipe_ingredients).where("LOWER(recipe_ingredients.name) LIKE ?", "%#{name.downcase}%")
  }
  scope :by_max_total_time, ->(minutes) { where("total_time_min <= ?", minutes) }
  scope :recent, -> { order(created_at: :desc) }

  def duplicate_for(user, entry_type: "duplicated")
    new_recipe = dup
    new_recipe.original_recipe_id = id
    new_recipe.creator_id = user.id
    new_recipe.nutrition_estimated_at = nil
    new_recipe.save!

    recipe_components.each do |comp|
      new_comp = comp.dup
      new_comp.recipe_id = new_recipe.id
      new_comp.save!
      component_map = { comp.id => new_comp.id }

      comp.recipe_ingredients.each do |ing|
        new_ing = ing.dup
        new_ing.recipe_id = new_recipe.id
        new_ing.component_id = new_comp.id
        new_ing.save!
      end

      comp.recipe_steps.each do |step|
        new_step = step.dup
        new_step.recipe_id = new_recipe.id
        new_step.component_id = new_comp.id
        new_step.save!
      end
    end

    recipe_ingredients.where(component_id: nil).each do |ing|
      new_ing = ing.dup
      new_ing.recipe_id = new_recipe.id
      new_ing.save!
    end

    recipe_steps.where(component_id: nil).each do |step|
      new_step = step.dup
      new_step.recipe_id = new_recipe.id
      new_step.save!
    end

    RecipeBookEntry.create!(user_id: user.id, recipe_id: new_recipe.id, entry_type: entry_type)
    new_recipe
  end

  def save_to_book_for(user)
    return if RecipeBookEntry.exists?(user_id: user.id, recipe_id: id)
    RecipeBookEntry.create!(user_id: user.id, recipe_id: id, entry_type: "saved")
  end

  def total_time_display
    return nil unless total_time_min
    total_time_min < 60 ? "#{total_time_min} min" : "#{total_time_min / 60}h #{total_time_min % 60}m"
  end

  def diet_type_label
    { "vegetarian" => "Vegetarian", "non_vegetarian" => "Non-Vegetarian", "eggetarian" => "Eggetarian" }[diet_type]
  end

  def meal_type_label
    meal_type&.humanize
  end

  private

  def create_owner_book_entry
    RecipeBookEntry.create!(user_id: creator_id, recipe_id: id, entry_type: "owned")
  end
end
