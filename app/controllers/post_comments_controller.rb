class PostCommentsController < ApplicationController
  def index
    matching_post_comments = PostComment.all

    @list_of_post_comments = matching_post_comments.order({ :created_at => :desc })

    render({ :template => "post_comment_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_post_comments = PostComment.where({ :id => the_id })

    @the_post_comment = matching_post_comments.at(0)

    render({ :template => "post_comment_templates/show" })
  end

  def create
    the_post_comment = PostComment.new
    the_post_comment.post_id = params.fetch("query_post_id")
    the_post_comment.user_id = params.fetch("query_user_id")
    the_post_comment.comment_text = params.fetch("query_comment_text")

    if the_post_comment.valid?
      the_post_comment.save
      redirect_to("/post_comments", { :notice => "Post comment created successfully." })
    else
      redirect_to("/post_comments", { :alert => the_post_comment.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_post_comment = PostComment.where({ :id => the_id }).at(0)

    the_post_comment.post_id = params.fetch("query_post_id")
    the_post_comment.user_id = params.fetch("query_user_id")
    the_post_comment.comment_text = params.fetch("query_comment_text")

    if the_post_comment.valid?
      the_post_comment.save
      redirect_to("/post_comments/#{the_post_comment.id}", { :notice => "Post comment updated successfully." } )
    else
      redirect_to("/post_comments/#{the_post_comment.id}", { :alert => the_post_comment.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_post_comment = PostComment.where({ :id => the_id }).at(0)

    the_post_comment.destroy

    redirect_to("/post_comments", { :notice => "Post comment deleted successfully." } )
  end
end
