class SearchController < ApplicationController

  def location_search
    @zipcode = params[:zipcode]
    #loads all the landmarks whose zipcode matches the one entered by the user
    @landmarks = Landmark.where('address LIKE :address', address: "%#{@zipcode}%" )

    if @landmarks.count == 0 || params[:zipcode].strip.empty?
      redirect_to '/'
      flash[:notice1] = "There are no landmarks in your area yet! Sign in or sign up to create a new landmark."
    end
  end
end
