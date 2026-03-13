Rails.application.routes.draw do
  devise_for :users

  root "feed#index"

  # Feed
  get "/feed", to: "feed#index"

  # My recipe book
  get "/my_book", to: "recipe_book#index"
  get "/my_book/search", to: "recipe_book#search"

  # Recipes
  get  "/recipes/new",          to: "recipes#new"
  get  "/recipes/import",       to: "recipes#import_form"
  post "/recipes/import",       to: "recipes#import"
  post "/insert_recipe",        to: "recipes#create"
  get  "/recipes/:path_id",     to: "recipes#show"
  post "/modify_recipe/:path_id", to: "recipes#update"
  get  "/delete_recipe/:path_id", to: "recipes#destroy"
  get  "/recipes/:path_id/cook",  to: "recipes#cook"
  post "/recipes/:path_id/duplicate",    to: "recipes#duplicate"
  post "/recipes/:path_id/save_to_book", to: "recipes#save_to_book"
  post "/recipes/:path_id/estimate_nutrition", to: "recipes#estimate_nutrition"

  # Recipe book entry (cooked + rating)
  post "/book_entry/:path_id/mark_cooked", to: "recipe_book_entries#mark_cooked"
  post "/book_entry/:path_id/rate",        to: "recipe_book_entries#rate"

  # Recipe ingredients (managed inline via recipe, but keep CRUD)
  post "/insert_recipe_ingredient",             to: "recipe_ingredients#create"
  post "/modify_recipe_ingredient/:path_id",    to: "recipe_ingredients#update"
  get  "/delete_recipe_ingredient/:path_id",    to: "recipe_ingredients#destroy"

  # Recipe components
  post "/insert_recipe_component",             to: "recipe_components#create"
  post "/modify_recipe_component/:path_id",    to: "recipe_components#update"
  get  "/delete_recipe_component/:path_id",    to: "recipe_components#destroy"

  # Recipe steps
  post "/insert_recipe_step",             to: "recipe_steps#create"
  post "/modify_recipe_step/:path_id",    to: "recipe_steps#update"
  get  "/delete_recipe_step/:path_id",    to: "recipe_steps#destroy"

  # Recipe notes
  post "/insert_recipe_note",             to: "recipe_notes#create"
  post "/modify_recipe_note/:path_id",    to: "recipe_notes#update"
  get  "/delete_recipe_note/:path_id",    to: "recipe_notes#destroy"

  # Recipe comments
  post "/insert_recipe_comment",          to: "recipe_comments#create"
  get  "/delete_recipe_comment/:path_id", to: "recipe_comments#destroy"

  # Recipe lists
  post "/insert_recipe_list",                      to: "recipe_lists#create"
  get  "/recipe_lists",                            to: "recipe_lists#index"
  get  "/recipe_lists/:path_id",                   to: "recipe_lists#show"
  post "/modify_recipe_list/:path_id",             to: "recipe_lists#update"
  get  "/delete_recipe_list/:path_id",             to: "recipe_lists#destroy"
  post "/recipe_lists/:path_id/add/:recipe_id",    to: "recipe_list_items#create"
  get  "/recipe_list_items/:path_id/remove",       to: "recipe_list_items#destroy"

  # Friends
  get  "/friends",                        to: "friendships#index"
  get  "/users",                          to: "users#index"
  get  "/users/:path_id",                 to: "users#show"
  get  "/users/:path_id/book",            to: "users#book"
  post "/friendships/request/:path_id",   to: "friendships#create"
  post "/friendships/accept/:path_id",    to: "friendships#accept"
  post "/friendships/decline/:path_id",   to: "friendships#decline"
  get  "/friendships/withdraw/:path_id",  to: "friendships#withdraw"

  # Food posts
  get  "/posts/new",           to: "food_posts#new"
  post "/insert_food_post",    to: "food_posts#create"
  get  "/posts/:path_id",      to: "food_posts#show"
  post "/modify_food_post/:path_id",  to: "food_posts#update"
  get  "/delete_food_post/:path_id",  to: "food_posts#destroy"

  # Post comments
  post "/insert_post_comment",          to: "post_comments#create"
  get  "/delete_post_comment/:path_id", to: "post_comments#destroy"

  # Post likes
  post "/toggle_post_like/:path_id",  to: "post_likes#toggle"
end
