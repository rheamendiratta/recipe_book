class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
    @pending_received = current_user.received_friend_requests.pending.includes(:requester)
    @pending_sent = current_user.sent_friend_requests.pending.includes(:addressee)
    render template: "friendship_templates/index"
  end

  def create
    addressee = User.find(params[:path_id])
    if addressee == current_user
      redirect_to "/friends", alert: "You can't friend yourself." and return
    end
    existing = current_user.friendship_with(addressee)
    if existing
      redirect_to "/friends", alert: "Friend request already exists." and return
    end
    Friendship.create!(requester_id: current_user.id, addressee_id: addressee.id, status: "pending")
    redirect_to "/users/#{addressee.id}", notice: "Friend request sent."
  end

  def accept
    friendship = current_user.received_friend_requests.find(params[:path_id])
    friendship.accept!
    redirect_to "/friends", notice: "Friend request accepted."
  end

  def decline
    friendship = current_user.received_friend_requests.find(params[:path_id])
    friendship.decline!
    redirect_to "/friends", notice: "Friend request declined."
  end

  def withdraw
    friendship = current_user.sent_friend_requests.find(params[:path_id])
    friendship.destroy
    redirect_to "/friends", notice: "Friend request withdrawn."
  end
end
