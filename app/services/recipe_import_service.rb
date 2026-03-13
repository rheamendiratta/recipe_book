class RecipeImportService
  def initialize(url)
    @url = url
  end

  def call
    html = fetch_html
    return nil unless html

    recipe_data = parse_json_ld(html)
    recipe_data ||= parse_with_ai(html)
    recipe_data
  end

  private

  def fetch_html
    response = HTTP.timeout(15).get(@url)
    response.status.success? ? response.to_s : nil
  rescue => e
    Rails.logger.error "RecipeImportService fetch failed: #{e.message}"
    nil
  end

  def parse_json_ld(html)
    doc = Nokogiri::HTML(html)
    doc.css('script[type="application/ld+json"]').each do |script|
      data = JSON.parse(script.text) rescue next
      data = data["@graph"]&.find { |item| Array(item["@type"]).include?("Recipe") } if data.is_a?(Hash) && data["@graph"]
      next unless data.is_a?(Hash) && Array(data["@type"]).include?("Recipe")
      return normalize_json_ld(data)
    end
    nil
  end

  def normalize_json_ld(data)
    {
      title: data["name"],
      description: data["description"],
      source_url: @url,
      source_type: "url",
      prep_time_min: parse_duration(data["prepTime"]),
      cook_time_min: parse_duration(data["cookTime"]),
      total_time_min: parse_duration(data["totalTime"]),
      base_servings: parse_yield(data["recipeYield"]),
      photo_url: extract_image(data["image"]),
      diet_type: nil,
      meal_type: normalize_meal_type(data["recipeCategory"]),
      ingredients: Array(data["recipeIngredient"]).map { |i| parse_ingredient_string(i) },
      steps: parse_instructions(data["recipeInstructions"])
    }
  end

  def parse_with_ai(html)
    doc = Nokogiri::HTML(html)
    doc.css("script, style, nav, header, footer").remove
    text = doc.text.gsub(/\s+/, " ").strip[0..6000]

    client = Anthropic::Client.new(api_key: ENV["ANTHROPIC_API_KEY"])
    response = client.messages(
      model: "claude-opus-4-6",
      max_tokens: 2000,
      messages: [{
        role: "user",
        content: <<~PROMPT
          Extract the recipe from this web page and return ONLY valid JSON (no markdown) with these exact keys:
          title (string), description (string), prep_time_min (integer or null), cook_time_min (integer or null),
          total_time_min (integer or null), base_servings (integer or null), photo_url (string or null),
          meal_type (one of: breakfast, main, snack, dessert, soup, salad, drink, appetizer, side, spread, homemade_staple, or null),
          diet_type (one of: vegetarian, non_vegetarian, eggetarian, or null),
          ingredients (array of {name, quantity, unit}),
          steps (array of {step_number, instruction})

          Page content:
          #{text}
        PROMPT
      }]
    )

    json_text = response.content[0].text
    json_match = json_text.match(/\{.*\}/m)
    return nil unless json_match
    JSON.parse(json_match[0], symbolize_names: true)
  rescue => e
    Rails.logger.error "RecipeImportService AI parsing failed: #{e.message}"
    nil
  end

  def parse_duration(iso)
    return nil unless iso.is_a?(String)
    total = 0
    total += $1.to_i * 60 if iso =~ /(\d+)H/
    total += $1.to_i if iso =~ /(\d+)M/
    total > 0 ? total : nil
  end

  def parse_yield(val)
    return val.to_i if val.is_a?(Integer)
    return val if val.is_a?(Integer)
    val.to_s.scan(/\d+/).first&.to_i
  end

  def extract_image(image)
    return nil unless image
    return image if image.is_a?(String)
    return image["url"] if image.is_a?(Hash)
    return image.first["url"] if image.is_a?(Array) && image.first.is_a?(Hash)
    image.first if image.is_a?(Array)
  end

  def parse_ingredient_string(str)
    # Very basic: "2 cups flour" -> {quantity: "2", unit: "cups", name: "flour"}
    parts = str.strip.split(" ", 3)
    if parts.length >= 3 && parts[0] =~ /\A[\d\/\.]+\z/
      { name: parts[2..].join(" "), quantity: parts[0], unit: parts[1] }
    elsif parts.length == 2 && parts[0] =~ /\A[\d\/\.]+\z/
      { name: parts[1], quantity: parts[0], unit: nil }
    else
      { name: str.strip, quantity: nil, unit: nil }
    end
  end

  def parse_instructions(instructions)
    return [] unless instructions
    steps = []
    if instructions.is_a?(Array)
      instructions.each_with_index do |item, i|
        text = item.is_a?(Hash) ? (item["text"] || item["name"]) : item.to_s
        if item.is_a?(Hash) && item["@type"] == "HowToSection"
          Array(item["itemListElement"]).each_with_index do |sub, j|
            sub_text = sub.is_a?(Hash) ? sub["text"] : sub.to_s
            steps << { step_number: steps.length + 1, instruction: sub_text }
          end
        else
          steps << { step_number: i + 1, instruction: text }
        end
      end
    elsif instructions.is_a?(String)
      instructions.split("\n").reject(&:blank?).each_with_index do |line, i|
        steps << { step_number: i + 1, instruction: line.strip }
      end
    end
    steps
  end

  def normalize_meal_type(category)
    return nil unless category
    val = Array(category).first.to_s.downcase
    Recipe::MEAL_TYPES.find { |t| val.include?(t) }
  end
end
