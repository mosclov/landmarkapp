class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @landmark = Landmark.find(params[:landmark_id])
    @new_fav = Favorite.new()
    @new_fav.user = current_user
    @new_fav.landmark = @landmark
    @new_fav.save
    redirect_to "/landmarks/#{@landmark.id}"
  end

  def unfavorite
    # DB doesn't know that the landmark_id and the user_id are unique pair so the
    # following solves that
    @unfavs = Favorite.where(landmark_id: params[:landmark_id], user: current_user)
    @unfavs.destroy_all
    redirect_to "/landmarks/#{params[:landmark_id]}"
  end

  def create_from_listing
    # @landmark = Landmark.find(params[:id])
    @favorite_landmark = Landmark.find(params[:landmark_id])
    @new_fav = Favorite.new()
    @new_fav.user = current_user
    @new_fav.landmark = @favorite_landmark
    @new_fav.save
    redirect_to "/landmarks"
  end

  def unfavorite_from_listing
    @unfavs = Favorite.where(landmark_id: params[:landmark_id], user: current_user)
    @unfavs.destroy_all
    redirect_to "/landmarks"
  end

  def unfavorite_from_profile
    @current_user = current_user
    @unfavs = Favorite.where(landmark_id: params[:landmark_id], user: current_user)
    @unfavs.destroy_all
    redirect_to "/users/#{@current_user.id}"
    # redirect_to user_path(current_user.id)
  end

end
