class PostLikesController < ApplicationController
  def index
    matching_post_likes = PostLike.all

    @list_of_post_likes = matching_post_likes.order({ :created_at => :desc })

    render({ :template => "post_like_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_post_likes = PostLike.where({ :id => the_id })

    @the_post_like = matching_post_likes.at(0)

    render({ :template => "post_like_templates/show" })
  end

  def create
    the_post_like = PostLike.new
    the_post_like.post_id = params.fetch("query_post_id")
    the_post_like.user_id = params.fetch("query_user_id")

    if the_post_like.valid?
      the_post_like.save
      redirect_to("/post_likes", { :notice => "Post like created successfully." })
    else
      redirect_to("/post_likes", { :alert => the_post_like.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_post_like = PostLike.where({ :id => the_id }).at(0)

    the_post_like.post_id = params.fetch("query_post_id")
    the_post_like.user_id = params.fetch("query_user_id")

    if the_post_like.valid?
      the_post_like.save
      redirect_to("/post_likes/#{the_post_like.id}", { :notice => "Post like updated successfully." } )
    else
      redirect_to("/post_likes/#{the_post_like.id}", { :alert => the_post_like.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_post_like = PostLike.where({ :id => the_id }).at(0)

    the_post_like.destroy

    redirect_to("/post_likes", { :notice => "Post like deleted successfully." } )
  end
end
