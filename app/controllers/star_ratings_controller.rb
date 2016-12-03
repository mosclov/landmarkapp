class StarRatingsController < ApplicationController
  before_action :set_star_rating, only: [:show, :edit, :update, :destroy]
  before_action :set_landmark
  before_action :authenticate_user!

  def new
    @star_rating = StarRating.new
  end

  def edit
  end

  def create
    @star_rating = StarRating.new(review_params)
    @star_rating.user_id = current_user.id
    @star_rating.truck_id = @landmark.id

    @landmark_ratings = StarRating.where(landmark_id: @landmark.id)

    # Check to see if contributor has already left a review for the truck and
    # if so destroy the review
    @landmark_rating.each do |rating|
      if rating.user_id == current_user.id
        rating.destroy
      end
    end

    if @star_rating.save
      redirect_to @landmark
    else
      render 'new'
    end
  end

  def update
    @star_rating.update(star_rating_params)
  end

  def destroy
    @star_rating.destroy
    redirect_to root_path
  end

  private
    def set_star_rating
      @star_rating = StarRating.find(params[:id])
    end

    def set_landmark
      @landmark = Landmark.find(params[:landmark_id])
    end

    def star_rating_params
      params.require(:star_rating).permit(:rating)
    end
end
