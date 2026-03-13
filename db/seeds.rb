# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.

puts "Clearing existing data..."
PostLike.destroy_all
PostComment.destroy_all
FoodPost.destroy_all
RecipeComment.destroy_all
RecipeNote.destroy_all
RecipeListItem.destroy_all
RecipeList.destroy_all
RecipeBookEntry.destroy_all
RecipeStep.destroy_all
RecipeIngredient.destroy_all
RecipeComponent.destroy_all
Recipe.destroy_all
Friendship.destroy_all
User.destroy_all

puts "Creating users..."

alice = User.create!(
  email: "alice@example.com",
  password: "password",
  display_name: "Alice"
)

bob = User.create!(
  email: "bob@example.com",
  password: "password",
  display_name: "Bob"
)

priya = User.create!(
  email: "priya@example.com",
  password: "password",
  display_name: "Priya"
)

puts "Creating friendships..."

Friendship.create!(requester: alice, addressee: bob, status: "accepted")
Friendship.create!(requester: priya, addressee: alice, status: "accepted")
Friendship.create!(requester: bob, addressee: priya, status: "pending")

puts "Creating recipes..."

# Alice's pasta recipe (after_create callback auto-creates owned RecipeBookEntry)
pasta = Recipe.create!(
  creator: alice,
  title: "Classic Spaghetti Carbonara",
  description: "A rich and creamy Italian pasta dish with eggs, cheese, pancetta, and black pepper.",
  source_type: "manual",
  base_servings: 4,
  prep_time_min: 10,
  cook_time_min: 20,
  total_time_min: 30,
  diet_type: "non_vegetarian",
  meal_type: "main",
  est_calories_per_serving: 620.0,
  est_carbs_g_per_serving: 72.0,
  est_fat_g_per_serving: 24.0,
  est_protein_g_per_serving: 28.0,
  est_fibre_g_per_serving: 3.0,
  nutrition_estimated_at: Time.current
)

sauce_comp = RecipeComponent.create!(recipe: pasta, name: "Sauce", sort_order: 1)
pasta_comp = RecipeComponent.create!(recipe: pasta, name: "Pasta", sort_order: 2)

RecipeIngredient.create!([
  { recipe: pasta, component: pasta_comp, name: "spaghetti", quantity: "400", unit: "g", sort_order: 1 },
  { recipe: pasta, component: sauce_comp, name: "pancetta or guanciale", quantity: "150", unit: "g", sort_order: 2 },
  { recipe: pasta, component: sauce_comp, name: "eggs", quantity: "4", unit: nil, sort_order: 3 },
  { recipe: pasta, component: sauce_comp, name: "Pecorino Romano", quantity: "60", unit: "g", sort_order: 4 },
  { recipe: pasta, component: sauce_comp, name: "black pepper", quantity: "1", unit: "tsp", sort_order: 5 },
  { recipe: pasta, component: pasta_comp, name: "salt", quantity: "1", unit: "tbsp", sort_order: 6 }
])

RecipeStep.create!([
  { recipe: pasta, component: pasta_comp, step_number: 1, instruction: "Boil a large pot of salted water and cook spaghetti until al dente." },
  { recipe: pasta, component: sauce_comp, step_number: 2, instruction: "Fry pancetta in a pan over medium heat until crispy. Remove from heat." },
  { recipe: pasta, component: sauce_comp, step_number: 3, instruction: "Whisk eggs and grated Pecorino together with black pepper in a bowl." },
  { recipe: pasta, step_number: 4, instruction: "Reserve 1 cup pasta water, then drain. Add hot pasta to the pancetta pan off heat." },
  { recipe: pasta, step_number: 5, instruction: "Pour egg mixture over pasta, tossing quickly and adding pasta water to create a creamy sauce. Serve immediately." }
])

# Bob's tomato soup
soup = Recipe.create!(
  creator: bob,
  title: "Tomato Basil Soup",
  description: "A simple, warming vegetarian soup made with fresh tomatoes and basil.",
  source_type: "manual",
  base_servings: 3,
  prep_time_min: 10,
  cook_time_min: 25,
  total_time_min: 35,
  diet_type: "vegetarian",
  meal_type: "soup",
  est_calories_per_serving: 180.0,
  est_carbs_g_per_serving: 22.0,
  est_fat_g_per_serving: 8.0,
  est_protein_g_per_serving: 4.0,
  est_fibre_g_per_serving: 5.0,
  nutrition_estimated_at: Time.current
)

RecipeIngredient.create!([
  { recipe: soup, name: "ripe tomatoes", quantity: "800", unit: "g", sort_order: 1 },
  { recipe: soup, name: "onion", quantity: "1", unit: "large", sort_order: 2 },
  { recipe: soup, name: "garlic cloves", quantity: "3", unit: nil, sort_order: 3 },
  { recipe: soup, name: "fresh basil", quantity: "1", unit: "handful", sort_order: 4 },
  { recipe: soup, name: "vegetable stock", quantity: "500", unit: "ml", sort_order: 5 },
  { recipe: soup, name: "olive oil", quantity: "2", unit: "tbsp", sort_order: 6 }
])

RecipeStep.create!([
  { recipe: soup, step_number: 1, instruction: "Saute diced onion and garlic in olive oil until soft, about 5 minutes." },
  { recipe: soup, step_number: 2, instruction: "Add chopped tomatoes and stock. Simmer for 20 minutes." },
  { recipe: soup, step_number: 3, instruction: "Blend until smooth, stir in fresh basil, season with salt and pepper." }
])

# Priya's masoor dal
dal = Recipe.create!(
  creator: priya,
  title: "Masoor Dal Tadka",
  description: "Comforting red lentil dal tempered with aromatic spices. A staple Indian dish.",
  source_type: "manual",
  base_servings: 4,
  prep_time_min: 10,
  cook_time_min: 30,
  total_time_min: 40,
  diet_type: "vegetarian",
  meal_type: "main",
  est_calories_per_serving: 280.0,
  est_carbs_g_per_serving: 38.0,
  est_fat_g_per_serving: 7.0,
  est_protein_g_per_serving: 14.0,
  est_fibre_g_per_serving: 9.0,
  nutrition_estimated_at: Time.current
)

dal_comp = RecipeComponent.create!(recipe: dal, name: "Dal", sort_order: 1)
tadka_comp = RecipeComponent.create!(recipe: dal, name: "Tadka (tempering)", sort_order: 2)

RecipeIngredient.create!([
  { recipe: dal, component: dal_comp, name: "red lentils (masoor dal)", quantity: "1", unit: "cup", sort_order: 1 },
  { recipe: dal, component: dal_comp, name: "water", quantity: "3", unit: "cups", sort_order: 2 },
  { recipe: dal, component: dal_comp, name: "turmeric", quantity: "0.5", unit: "tsp", sort_order: 3 },
  { recipe: dal, component: tadka_comp, name: "ghee", quantity: "2", unit: "tbsp", sort_order: 4 },
  { recipe: dal, component: tadka_comp, name: "cumin seeds", quantity: "1", unit: "tsp", sort_order: 5 },
  { recipe: dal, component: tadka_comp, name: "garlic", quantity: "4", unit: "cloves", sort_order: 6 },
  { recipe: dal, component: tadka_comp, name: "dried red chilli", quantity: "2", unit: nil, sort_order: 7 },
  { recipe: dal, component: tadka_comp, name: "tomato", quantity: "1", unit: "medium", sort_order: 8 }
])

RecipeStep.create!([
  { recipe: dal, component: dal_comp, step_number: 1, instruction: "Rinse lentils and boil with water and turmeric until soft, about 20 minutes. Mash slightly." },
  { recipe: dal, component: tadka_comp, step_number: 2, instruction: "Heat ghee in a small pan. Add cumin seeds and let them splutter." },
  { recipe: dal, component: tadka_comp, step_number: 3, instruction: "Add sliced garlic and dried chillies. Fry until golden." },
  { recipe: dal, component: tadka_comp, step_number: 4, instruction: "Add chopped tomato and cook until soft. Pour tadka over the dal and stir." },
  { recipe: dal, step_number: 5, instruction: "Season with salt and serve hot with rice or roti." }
])

puts "Setting up recipe book entries..."

# Bob saves Alice's pasta
pasta.save_to_book_for(bob)
bob_pasta_entry = RecipeBookEntry.find_by(user_id: bob.id, recipe_id: pasta.id)
bob_pasta_entry.update!(has_cooked: true, star_rating: 5)

# Alice marks her own pasta as cooked and rated
alice_pasta_entry = RecipeBookEntry.find_by(user_id: alice.id, recipe_id: pasta.id)
alice_pasta_entry.update!(has_cooked: true, star_rating: 4)

# Alice saves Priya's dal
dal.save_to_book_for(alice)

# Bob marks soup as cooked
bob_soup_entry = RecipeBookEntry.find_by(user_id: bob.id, recipe_id: soup.id)
bob_soup_entry.update!(has_cooked: true, star_rating: 4)

puts "Creating recipe lists..."

alice_list = RecipeList.create!(user: alice, name: "Quick Weeknight Dinners")
RecipeListItem.create!(list: alice_list, recipe: pasta)

bob_list = RecipeList.create!(user: bob, name: "Vegetarian Favourites")
RecipeListItem.create!(list: bob_list, recipe: soup)
RecipeListItem.create!(list: bob_list, recipe: dal)

puts "Creating notes and comments..."

RecipeNote.create!(recipe: pasta, user: alice, note_text: "Don't add cream — the creaminess comes purely from the eggs and pasta water!")
RecipeNote.create!(recipe: dal, user: alice, note_text: "Priya's recommendation: serve with a squeeze of lemon on top.")

RecipeComment.create!(recipe: dal, user: alice, comment_text: "Made this last night, absolutely delicious. The tadka makes it!")
RecipeComment.create!(recipe: pasta, user: bob, comment_text: "Classic recipe. I used guanciale and it was even better.")

puts "Creating three more users..."

ravi = User.create!(
  email: "ravi@example.com",
  password: "password",
  display_name: "Ravi"
)

mei = User.create!(
  email: "mei@example.com",
  password: "password",
  display_name: "Mei"
)

leila = User.create!(
  email: "leila@example.com",
  password: "password",
  display_name: "Leila"
)

# Friendships for new users
Friendship.create!(requester: ravi, addressee: alice, status: "accepted")
Friendship.create!(requester: ravi, addressee: priya, status: "accepted")
Friendship.create!(requester: mei, addressee: bob, status: "accepted")
Friendship.create!(requester: mei, addressee: ravi, status: "accepted")
Friendship.create!(requester: leila, addressee: alice, status: "accepted")
Friendship.create!(requester: leila, addressee: mei, status: "pending")
Friendship.create!(requester: bob, addressee: leila, status: "pending")

puts "Creating recipes for new users..."

# Ravi's chicken biryani
biryani = Recipe.create!(
  creator: ravi,
  title: "Chicken Dum Biryani",
  description: "Fragrant basmati rice slow-cooked with spiced chicken, caramelised onions, and saffron. Classic Hyderabadi style.",
  source_type: "manual",
  base_servings: 5,
  prep_time_min: 30,
  cook_time_min: 60,
  total_time_min: 90,
  diet_type: "non_vegetarian",
  meal_type: "main",
  est_calories_per_serving: 520.0,
  est_carbs_g_per_serving: 62.0,
  est_fat_g_per_serving: 18.0,
  est_protein_g_per_serving: 30.0,
  est_fibre_g_per_serving: 3.0,
  nutrition_estimated_at: Time.current
)

biryani_rice = RecipeComponent.create!(recipe: biryani, name: "Rice", sort_order: 1)
biryani_chicken = RecipeComponent.create!(recipe: biryani, name: "Chicken Marinade", sort_order: 2)
biryani_assembly = RecipeComponent.create!(recipe: biryani, name: "Dum Assembly", sort_order: 3)

RecipeIngredient.create!([
  { recipe: biryani, component: biryani_rice, name: "basmati rice", quantity: "500", unit: "g", sort_order: 1 },
  { recipe: biryani, component: biryani_rice, name: "whole spices (bay leaves, cardamom, cloves)", quantity: "1", unit: "tbsp mix", sort_order: 2 },
  { recipe: biryani, component: biryani_chicken, name: "chicken thighs (bone-in)", quantity: "800", unit: "g", sort_order: 3 },
  { recipe: biryani, component: biryani_chicken, name: "Greek yogurt", quantity: "200", unit: "g", sort_order: 4 },
  { recipe: biryani, component: biryani_chicken, name: "biryani masala", quantity: "2", unit: "tbsp", sort_order: 5 },
  { recipe: biryani, component: biryani_chicken, name: "ginger-garlic paste", quantity: "2", unit: "tbsp", sort_order: 6 },
  { recipe: biryani, component: biryani_chicken, name: "chilli powder", quantity: "1", unit: "tsp", sort_order: 7 },
  { recipe: biryani, component: biryani_assembly, name: "fried onions (birista)", quantity: "2", unit: "large handfuls", sort_order: 8 },
  { recipe: biryani, component: biryani_assembly, name: "saffron in warm milk", quantity: "2", unit: "tbsp", sort_order: 9 },
  { recipe: biryani, component: biryani_assembly, name: "ghee", quantity: "3", unit: "tbsp", sort_order: 10 }
])

RecipeStep.create!([
  { recipe: biryani, component: biryani_chicken, step_number: 1, instruction: "Mix chicken with yogurt, biryani masala, ginger-garlic paste, chilli powder, and salt. Marinate at least 2 hours." },
  { recipe: biryani, component: biryani_rice, step_number: 2, instruction: "Soak basmati for 30 minutes. Parboil with whole spices and salt until 70% cooked. Drain." },
  { recipe: biryani, component: biryani_assembly, step_number: 3, instruction: "Layer marinated chicken at the bottom of a heavy pot. Top with half the rice." },
  { recipe: biryani, component: biryani_assembly, step_number: 4, instruction: "Scatter fried onions, drizzle saffron milk and ghee. Add remaining rice." },
  { recipe: biryani, step_number: 5, instruction: "Seal pot with dough or foil. Cook on high 5 min, then lowest heat for 35 minutes. Rest 10 min before opening." }
])

# Mei's tofu stir-fry
stirfry = Recipe.create!(
  creator: mei,
  title: "Sesame Tofu & Broccoli Stir-fry",
  description: "Crispy pan-fried tofu and tender-crisp broccoli in a sticky sesame-ginger sauce. Ready in 20 minutes.",
  source_type: "manual",
  base_servings: 2,
  prep_time_min: 10,
  cook_time_min: 15,
  total_time_min: 25,
  diet_type: "vegetarian",
  meal_type: "main",
  est_calories_per_serving: 310.0,
  est_carbs_g_per_serving: 28.0,
  est_fat_g_per_serving: 16.0,
  est_protein_g_per_serving: 18.0,
  est_fibre_g_per_serving: 5.0,
  nutrition_estimated_at: Time.current
)

RecipeIngredient.create!([
  { recipe: stirfry, name: "firm tofu", quantity: "400", unit: "g", sort_order: 1 },
  { recipe: stirfry, name: "broccoli florets", quantity: "300", unit: "g", sort_order: 2 },
  { recipe: stirfry, name: "soy sauce", quantity: "3", unit: "tbsp", sort_order: 3 },
  { recipe: stirfry, name: "sesame oil", quantity: "1", unit: "tbsp", sort_order: 4 },
  { recipe: stirfry, name: "fresh ginger", quantity: "1", unit: "inch piece", sort_order: 5 },
  { recipe: stirfry, name: "garlic cloves", quantity: "3", unit: nil, sort_order: 6 },
  { recipe: stirfry, name: "honey or maple syrup", quantity: "1", unit: "tbsp", sort_order: 7 },
  { recipe: stirfry, name: "cornflour", quantity: "1", unit: "tsp", sort_order: 8 },
  { recipe: stirfry, name: "sesame seeds", quantity: "1", unit: "tbsp", sort_order: 9 }
])

RecipeStep.create!([
  { recipe: stirfry, step_number: 1, instruction: "Press tofu dry, cube it, toss in cornflour. Pan-fry in a little oil until golden on all sides. Set aside." },
  { recipe: stirfry, step_number: 2, instruction: "Blanch broccoli in boiling water for 2 minutes. Drain." },
  { recipe: stirfry, step_number: 3, instruction: "Whisk soy sauce, sesame oil, ginger, garlic, and honey into a sauce." },
  { recipe: stirfry, step_number: 4, instruction: "Return pan to high heat. Add broccoli and tofu, pour over sauce, toss 2 minutes until glossy. Top with sesame seeds." }
])

# Leila's lamb kofta
kofta = Recipe.create!(
  creator: leila,
  title: "Lamb Kofta with Minted Yogurt",
  description: "Spiced ground lamb skewers served with a cool mint yogurt dip and warm flatbreads.",
  source_type: "manual",
  base_servings: 4,
  prep_time_min: 20,
  cook_time_min: 15,
  total_time_min: 35,
  diet_type: "non_vegetarian",
  meal_type: "main",
  est_calories_per_serving: 450.0,
  est_carbs_g_per_serving: 12.0,
  est_fat_g_per_serving: 28.0,
  est_protein_g_per_serving: 38.0,
  est_fibre_g_per_serving: 2.0,
  nutrition_estimated_at: Time.current
)

kofta_meat = RecipeComponent.create!(recipe: kofta, name: "Kofta", sort_order: 1)
kofta_dip = RecipeComponent.create!(recipe: kofta, name: "Minted Yogurt", sort_order: 2)

RecipeIngredient.create!([
  { recipe: kofta, component: kofta_meat, name: "ground lamb", quantity: "600", unit: "g", sort_order: 1 },
  { recipe: kofta, component: kofta_meat, name: "onion (grated)", quantity: "1", unit: "small", sort_order: 2 },
  { recipe: kofta, component: kofta_meat, name: "cumin", quantity: "1.5", unit: "tsp", sort_order: 3 },
  { recipe: kofta, component: kofta_meat, name: "coriander (ground)", quantity: "1", unit: "tsp", sort_order: 4 },
  { recipe: kofta, component: kofta_meat, name: "cinnamon", quantity: "0.5", unit: "tsp", sort_order: 5 },
  { recipe: kofta, component: kofta_meat, name: "fresh parsley", quantity: "1", unit: "handful", sort_order: 6 },
  { recipe: kofta, component: kofta_dip, name: "Greek yogurt", quantity: "200", unit: "g", sort_order: 7 },
  { recipe: kofta, component: kofta_dip, name: "fresh mint", quantity: "1", unit: "handful", sort_order: 8 },
  { recipe: kofta, component: kofta_dip, name: "lemon juice", quantity: "1", unit: "tbsp", sort_order: 9 }
])

RecipeStep.create!([
  { recipe: kofta, component: kofta_meat, step_number: 1, instruction: "Combine lamb, grated onion, cumin, coriander, cinnamon, parsley, salt and pepper. Mix well and refrigerate 15 minutes." },
  { recipe: kofta, component: kofta_dip, step_number: 2, instruction: "Blitz yogurt, mint, and lemon juice together. Season with salt." },
  { recipe: kofta, component: kofta_meat, step_number: 3, instruction: "Shape meat around skewers into 10cm sausage shapes." },
  { recipe: kofta, component: kofta_meat, step_number: 4, instruction: "Grill or pan-fry over high heat, turning, until cooked through — about 10 minutes total. Serve with yogurt dip." }
])

puts "Setting up book entries for new users..."

# Ravi saves Alice's pasta and Priya's dal
pasta.save_to_book_for(ravi)
ravi_pasta_entry = RecipeBookEntry.find_by(user_id: ravi.id, recipe_id: pasta.id)
ravi_pasta_entry.update!(has_cooked: true, star_rating: 5)

dal.save_to_book_for(ravi)
ravi_biryani_entry = RecipeBookEntry.find_by(user_id: ravi.id, recipe_id: biryani.id)
ravi_biryani_entry.update!(has_cooked: true, star_rating: 5)

# Mei saves Bob's soup
soup.save_to_book_for(mei)
mei_soup_entry = RecipeBookEntry.find_by(user_id: mei.id, recipe_id: soup.id)
mei_soup_entry.update!(has_cooked: true, star_rating: 4)

# Leila duplicates Ravi's biryani
biryani.duplicate_for(leila)
leila_stirfry_entry = RecipeBookEntry.find_by(user_id: leila.id, recipe_id: kofta.id)
leila_stirfry_entry.update!(has_cooked: true, star_rating: 4)

puts "Creating recipe lists for new users..."

ravi_list = RecipeList.create!(user: ravi, name: "Indian Classics")
RecipeListItem.create!(list: ravi_list, recipe: biryani)
RecipeListItem.create!(list: ravi_list, recipe: dal)

mei_list = RecipeList.create!(user: mei, name: "Quick Weeknight Meals")
RecipeListItem.create!(list: mei_list, recipe: stirfry)
RecipeListItem.create!(list: mei_list, recipe: soup)

puts "Creating notes and comments for new users..."

RecipeNote.create!(recipe: biryani, user: ravi, note_text: "Use aged basmati if you can find it — the grains stay separate much better during dum.")
RecipeNote.create!(recipe: kofta, user: leila, note_text: "Can be prepped the night before and kept in the fridge. Actually improves with resting!")

RecipeComment.create!(recipe: biryani, user: priya, comment_text: "Ravi this brings back memories of Hyderabad! Perfect.")
RecipeComment.create!(recipe: biryani, user: alice, comment_text: "Made this for a dinner party and everyone asked for the recipe.")
RecipeComment.create!(recipe: stirfry, user: mei, comment_text: "Great for meal prep — holds up well in the fridge for 2 days.")
RecipeComment.create!(recipe: kofta, user: ravi, comment_text: "The minted yogurt is what makes this dish. Don't skip it!")

puts "Creating food posts..."

post1 = FoodPost.create!(
  user: alice,
  recipe: pasta,
  photo_url: "https://images.unsplash.com/photo-1612874742237-6526221588e3?w=800",
  caption: "Sunday carbonara night! The secret is taking it off the heat before adding the eggs."
)

post2 = FoodPost.create!(
  user: bob,
  recipe: soup,
  photo_url: "https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800",
  caption: "Cosy tomato soup on a rainy afternoon. So simple and so good."
)

post3 = FoodPost.create!(
  user: priya,
  recipe: dal,
  photo_url: "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
  caption: "Dal tadka — mum's recipe, perfected over years. Nothing beats the smell of fresh tadka."
)

puts "Creating post likes and comments..."

PostLike.create!(post: post1, user: bob)
PostLike.create!(post: post1, user: priya)
PostLike.create!(post: post3, user: alice)
PostLike.create!(post: post2, user: alice)

PostComment.create!(post: post1, user: bob, comment_text: "That looks incredible, Alice!")
PostComment.create!(post: post3, user: alice, comment_text: "Priya this is making me hungry right now")
PostComment.create!(post: post2, user: priya, comment_text: "Perfect soup weather!")

post4 = FoodPost.create!(
  user: ravi,
  recipe: biryani,
  photo_url: "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=800",
  caption: "Dum biryani sealed and resting. The anticipation is the hardest part."
)

post5 = FoodPost.create!(
  user: mei,
  recipe: stirfry,
  photo_url: "https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800",
  caption: "20-minute tofu stir-fry. Proof that weeknight dinners don't have to be boring."
)

post6 = FoodPost.create!(
  user: leila,
  recipe: kofta,
  photo_url: "https://images.unsplash.com/photo-1529042410759-befb1204b468?w=800",
  caption: "Kofta off the grill. The mint yogurt makes everything better."
)

PostLike.create!(post: post4, user: priya)
PostLike.create!(post: post4, user: alice)
PostLike.create!(post: post4, user: mei)
PostLike.create!(post: post5, user: ravi)
PostLike.create!(post: post5, user: bob)
PostLike.create!(post: post6, user: alice)
PostLike.create!(post: post6, user: ravi)

PostComment.create!(post: post4, user: priya, comment_text: "Ravi the colour on that rice is gorgeous!")
PostComment.create!(post: post5, user: bob, comment_text: "Saving this for next week. Looks so fresh.")
PostComment.create!(post: post6, user: alice, comment_text: "Need this in my life immediately.")

puts "\nDone! Seeded:"
puts "  #{User.count} users"
puts "    -> alice@example.com / password"
puts "    -> bob@example.com   / password"
puts "    -> priya@example.com / password"
puts "  #{Recipe.count} recipes"
puts "  #{RecipeBookEntry.count} recipe book entries"
puts "  #{RecipeIngredient.count} ingredients across #{RecipeComponent.count} components"
puts "  #{RecipeStep.count} steps"
puts "  #{FoodPost.count} food posts"
puts "  #{Friendship.count} friendships"
puts "  #{RecipeList.count} recipe lists"
