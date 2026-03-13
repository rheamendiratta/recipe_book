class FeedController < ApplicationController
  def index
    friend_ids = current_user.friends.pluck(:id)
    all_user_ids = friend_ids + [current_user.id]

    @food_posts = FoodPost.where(user_id: all_user_ids).includes(:user, :recipe, :post_likes, :post_comments).order(created_at: :desc).limit(50)
    @recent_entries = RecipeBookEntry.where(user_id: all_user_ids).includes(recipe: :creator).order(created_at: :desc).limit(50)

    # Merge and sort by created_at
    @feed_items = (@food_posts.to_a + @recent_entries.to_a).sort_by(&:created_at).reverse.first(50)

    render template: "feed_templates/index"
  end
end
