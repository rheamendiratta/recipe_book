class UsersController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id).order(:display_name, :email)
    @friendships = {}
    @users.each { |u| @friendships[u.id] = current_user.friendship_with(u) }
    render template: "user_templates/index"
  end

  def show
    @user = User.find(params[:path_id])
    @friendship = current_user.friendship_with(@user)
    @recent_posts = @user.food_posts.includes(:recipe).order(created_at: :desc).limit(6) if current_user.friend?(@user) || @user == current_user
    render template: "user_templates/show"
  end

  def book
    @user = User.find(params[:path_id])
    unless current_user.friend?(@user) || @user == current_user
      redirect_to "/users/#{@user.id}", alert: "You must be friends to view their recipe book." and return
    end
    @entries = @user.recipe_book_entries.includes(:recipe).order(created_at: :desc)
    @recipes = @entries.map(&:recipe).compact
    render template: "user_templates/book"
  end
end
