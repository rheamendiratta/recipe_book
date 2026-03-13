Rails.application.routes.draw do
  # Routes for the Post like resource:

  # CREATE
  post("/insert_post_like", { :controller => "post_likes", :action => "create" })

  # READ
  get("/post_likes", { :controller => "post_likes", :action => "index" })

  get("/post_likes/:path_id", { :controller => "post_likes", :action => "show" })

  # UPDATE

  post("/modify_post_like/:path_id", { :controller => "post_likes", :action => "update" })

  # DELETE
  get("/delete_post_like/:path_id", { :controller => "post_likes", :action => "destroy" })

  #------------------------------

  # Routes for the Post comment resource:

  # CREATE
  post("/insert_post_comment", { :controller => "post_comments", :action => "create" })

  # READ
  get("/post_comments", { :controller => "post_comments", :action => "index" })

  get("/post_comments/:path_id", { :controller => "post_comments", :action => "show" })

  # UPDATE

  post("/modify_post_comment/:path_id", { :controller => "post_comments", :action => "update" })

  # DELETE
  get("/delete_post_comment/:path_id", { :controller => "post_comments", :action => "destroy" })

  #------------------------------

  # Routes for the Food post resource:

  # CREATE
  post("/insert_food_post", { :controller => "food_posts", :action => "create" })

  # READ
  get("/food_posts", { :controller => "food_posts", :action => "index" })

  get("/food_posts/:path_id", { :controller => "food_posts", :action => "show" })

  # UPDATE

  post("/modify_food_post/:path_id", { :controller => "food_posts", :action => "update" })

  # DELETE
  get("/delete_food_post/:path_id", { :controller => "food_posts", :action => "destroy" })

  #------------------------------

  # Routes for the Recipe step resource:

  # CREATE
  post("/insert_recipe_step", { :controller => "recipe_steps", :action => "create" })

  # READ
  get("/recipe_steps", { :controller => "recipe_steps", :action => "index" })

  get("/recipe_steps/:path_id", { :controller => "recipe_steps", :action => "show" })

  # UPDATE

  post("/modify_recipe_step/:path_id", { :controller => "recipe_steps", :action => "update" })

  # DELETE
  get("/delete_recipe_step/:path_id", { :controller => "recipe_steps", :action => "destroy" })

  #------------------------------

  # Routes for the Recipe list item resource:

  # CREATE
  post("/insert_recipe_list_item", { :controller => "recipe_list_items", :action => "create" })

  # READ
  get("/recipe_list_items", { :controller => "recipe_list_items", :action => "index" })

  get("/recipe_list_items/:path_id", { :controller => "recipe_list_items", :action => "show" })

  # UPDATE

  post("/modify_recipe_list_item/:path_id", { :controller => "recipe_list_items", :action => "update" })

  # DELETE
  get("/delete_recipe_list_item/:path_id", { :controller => "recipe_list_items", :action => "destroy" })

  #------------------------------

  # Routes for the Recipe ingredient resource:

  # CREATE
  post("/insert_recipe_ingredient", { :controller => "recipe_ingredients", :action => "create" })

  # READ
  get("/recipe_ingredients", { :controller => "recipe_ingredients", :action => "index" })

  get("/recipe_ingredients/:path_id", { :controller => "recipe_ingredients", :action => "show" })

  # UPDATE

  post("/modify_recipe_ingredient/:path_id", { :controller => "recipe_ingredients", :action => "update" })

  # DELETE
  get("/delete_recipe_ingredient/:path_id", { :controller => "recipe_ingredients", :action => "destroy" })

  #------------------------------

  # Routes for the Recipe component resource:

  # CREATE
  post("/insert_recipe_component", { :controller => "recipe_components", :action => "create" })

  # READ
  get("/recipe_components", { :controller => "recipe_components", :action => "index" })

  get("/recipe_components/:path_id", { :controller => "recipe_components", :action => "show" })

  # UPDATE

  post("/modify_recipe_component/:path_id", { :controller => "recipe_components", :action => "update" })

  # DELETE
  get("/delete_recipe_component/:path_id", { :controller => "recipe_components", :action => "destroy" })

  #------------------------------

  # Routes for the Recipe comment resource:

  # CREATE
  post("/insert_recipe_comment", { :controller => "recipe_comments", :action => "create" })

  # READ
  get("/recipe_comments", { :controller => "recipe_comments", :action => "index" })

  get("/recipe_comments/:path_id", { :controller => "recipe_comments", :action => "show" })

  # UPDATE

  post("/modify_recipe_comment/:path_id", { :controller => "recipe_comments", :action => "update" })

  # DELETE
  get("/delete_recipe_comment/:path_id", { :controller => "recipe_comments", :action => "destroy" })

  #------------------------------

  # Routes for the Recipe note resource:

  # CREATE
  post("/insert_recipe_note", { :controller => "recipe_notes", :action => "create" })

  # READ
  get("/recipe_notes", { :controller => "recipe_notes", :action => "index" })

  get("/recipe_notes/:path_id", { :controller => "recipe_notes", :action => "show" })

  # UPDATE

  post("/modify_recipe_note/:path_id", { :controller => "recipe_notes", :action => "update" })

  # DELETE
  get("/delete_recipe_note/:path_id", { :controller => "recipe_notes", :action => "destroy" })

  #------------------------------

  # Routes for the Recipe book entry resource:

  # CREATE
  post("/insert_recipe_book_entry", { :controller => "recipe_book_entries", :action => "create" })

  # READ
  get("/recipe_book_entries", { :controller => "recipe_book_entries", :action => "index" })

  get("/recipe_book_entries/:path_id", { :controller => "recipe_book_entries", :action => "show" })

  # UPDATE

  post("/modify_recipe_book_entry/:path_id", { :controller => "recipe_book_entries", :action => "update" })

  # DELETE
  get("/delete_recipe_book_entry/:path_id", { :controller => "recipe_book_entries", :action => "destroy" })

  #------------------------------

  # Routes for the Recipe list resource:

  # CREATE
  post("/insert_recipe_list", { :controller => "recipe_lists", :action => "create" })

  # READ
  get("/recipe_lists", { :controller => "recipe_lists", :action => "index" })

  get("/recipe_lists/:path_id", { :controller => "recipe_lists", :action => "show" })

  # UPDATE

  post("/modify_recipe_list/:path_id", { :controller => "recipe_lists", :action => "update" })

  # DELETE
  get("/delete_recipe_list/:path_id", { :controller => "recipe_lists", :action => "destroy" })

  #------------------------------

  # Routes for the Friendship resource:

  # CREATE
  post("/insert_friendship", { :controller => "friendships", :action => "create" })

  # READ
  get("/friendships", { :controller => "friendships", :action => "index" })

  get("/friendships/:path_id", { :controller => "friendships", :action => "show" })

  # UPDATE

  post("/modify_friendship/:path_id", { :controller => "friendships", :action => "update" })

  # DELETE
  get("/delete_friendship/:path_id", { :controller => "friendships", :action => "destroy" })

  #------------------------------

  devise_for :users
  # Routes for the Recipe resource:

  # CREATE
  post("/insert_recipe", { :controller => "recipes", :action => "create" })

  # READ
  get("/recipes", { :controller => "recipes", :action => "index" })

  get("/recipes/:path_id", { :controller => "recipes", :action => "show" })

  # UPDATE

  post("/modify_recipe/:path_id", { :controller => "recipes", :action => "update" })

  # DELETE
  get("/delete_recipe/:path_id", { :controller => "recipes", :action => "destroy" })

  #------------------------------

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:
  # get("/your_first_screen", { :controller => "pages", :action => "first" })

  root "recipes#index"
end
