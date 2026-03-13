class NutritionService
  def initialize(recipe)
    @recipe = recipe
  end

  def estimate!
    ingredients_text = @recipe.recipe_ingredients.map(&:display_quantity).join("\n")
    return false if ingredients_text.blank?

    client = Anthropic::Client.new(api_key: ENV["ANTHROPIC_API_KEY"])
    response = client.messages.create(
      model: "claude-opus-4-6",
      max_tokens: 500,
      messages: [{
        role: "user",
        content: <<~PROMPT
          Estimate nutrition per serving for a recipe with #{@recipe.base_servings || 1} servings.
          Return ONLY valid JSON (no markdown) with these exact float keys (rounded to 1 decimal):
          calories_per_serving, carbs_g_per_serving, fat_g_per_serving, protein_g_per_serving, fibre_g_per_serving

          Ingredients:
          #{ingredients_text}
        PROMPT
      }]
    )

    json_text = response.content[0].text
    json_match = json_text.match(/\{.*\}/m)
    return false unless json_match

    data = JSON.parse(json_match[0])
    @recipe.update!(
      est_calories_per_serving: data["calories_per_serving"],
      est_carbs_g_per_serving: data["carbs_g_per_serving"],
      est_fat_g_per_serving: data["fat_g_per_serving"],
      est_protein_g_per_serving: data["protein_g_per_serving"],
      est_fibre_g_per_serving: data["fibre_g_per_serving"],
      nutrition_estimated_at: Time.current
    )
    true
  rescue => e
    Rails.logger.error "NutritionService failed: #{e.message}"
    false
  end
end
