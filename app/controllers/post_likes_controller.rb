class PostLikesController < ApplicationController
  def toggle
    post = FoodPost.find(params[:path_id])
    existing = post.post_likes.find_by(user_id: current_user.id)
    if existing
      existing.destroy
    else
      post.post_likes.create!(user_id: current_user.id)
    end
    redirect_back fallback_location: "/posts/#{post.id}"
  end
end
