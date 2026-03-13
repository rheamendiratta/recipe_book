class PostCommentsController < ApplicationController
  def create
    post = FoodPost.find(params[:query_post_id])
    unless post.user_id == current_user.id || current_user.friend?(post.user)
      redirect_to "/feed", alert: "Not authorized." and return
    end
    comment = post.post_comments.new(user_id: current_user.id, comment_text: params[:query_comment_text])
    if comment.save
      redirect_to "/posts/#{post.id}", notice: "Comment added."
    else
      redirect_to "/posts/#{post.id}", alert: comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    comment = PostComment.find(params[:path_id])
    unless comment.user_id == current_user.id || comment.post.user_id == current_user.id
      redirect_to "/feed", alert: "Not authorized." and return
    end
    post_id = comment.post_id
    comment.destroy
    redirect_to "/posts/#{post_id}", notice: "Comment deleted."
  end
end
