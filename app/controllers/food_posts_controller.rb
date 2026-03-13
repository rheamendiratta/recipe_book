class FoodPostsController < ApplicationController
  def new
    @my_book_recipes = current_user.recipe_book_entries.includes(:recipe).map(&:recipe).compact
    render template: "food_post_templates/new"
  end

  def create
    post = FoodPost.new(
      user_id: current_user.id,
      recipe_id: params[:query_recipe_id].presence,
      caption: params[:query_caption]
    )
    if params[:photo].present?
      post.photo.attach(params[:photo])
    elsif params[:query_photo_url].present?
      post.photo_url = params[:query_photo_url]
    end
    if post.save
      redirect_to "/feed", notice: "Post shared!"
    else
      redirect_to "/posts/new", alert: post.errors.full_messages.to_sentence
    end
  end

  def show
    @post = FoodPost.find(params[:path_id])
    unless @post.user_id == current_user.id || current_user.friend?(@post.user)
      redirect_to "/feed", alert: "Not authorized." and return
    end
    @comments = @post.post_comments.includes(:user).order(created_at: :asc)
    @liked = @post.post_likes.exists?(user_id: current_user.id)
    @like_count = @post.post_likes.count
    render template: "food_post_templates/show"
  end

  def update
    post = FoodPost.find(params[:path_id])
    require_ownership(post)
    return if performed?
    post.update(caption: params[:query_caption])
    redirect_to "/posts/#{post.id}", notice: "Post updated."
  end

  def destroy
    post = FoodPost.find(params[:path_id])
    require_ownership(post)
    return if performed?
    post.destroy
    redirect_to "/feed", notice: "Post deleted."
  end
end
