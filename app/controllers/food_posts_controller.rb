class FoodPostsController < ApplicationController
  def index
    matching_food_posts = FoodPost.all

    @list_of_food_posts = matching_food_posts.order({ :created_at => :desc })

    render({ :template => "food_post_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_food_posts = FoodPost.where({ :id => the_id })

    @the_food_post = matching_food_posts.at(0)

    render({ :template => "food_post_templates/show" })
  end

  def create
    the_food_post = FoodPost.new
    the_food_post.user_id = params.fetch("query_user_id")
    the_food_post.recipe_id = params.fetch("query_recipe_id")
    the_food_post.photo_url = params.fetch("query_photo_url")
    the_food_post.caption = params.fetch("query_caption")

    if the_food_post.valid?
      the_food_post.save
      redirect_to("/food_posts", { :notice => "Food post created successfully." })
    else
      redirect_to("/food_posts", { :alert => the_food_post.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_food_post = FoodPost.where({ :id => the_id }).at(0)

    the_food_post.user_id = params.fetch("query_user_id")
    the_food_post.recipe_id = params.fetch("query_recipe_id")
    the_food_post.photo_url = params.fetch("query_photo_url")
    the_food_post.caption = params.fetch("query_caption")

    if the_food_post.valid?
      the_food_post.save
      redirect_to("/food_posts/#{the_food_post.id}", { :notice => "Food post updated successfully." } )
    else
      redirect_to("/food_posts/#{the_food_post.id}", { :alert => the_food_post.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_food_post = FoodPost.where({ :id => the_id }).at(0)

    the_food_post.destroy

    redirect_to("/food_posts", { :notice => "Food post deleted successfully." } )
  end
end
