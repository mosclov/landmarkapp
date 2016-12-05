class SearchController < ApplicationController

  def location_search
    @zipcode = params[:zipcode]
    #loads all the landmarks whose zipcode matches the one entered by the user 
    @landmarks = Landmark.where('address LIKE :address', address: "%#{@zipcode}%" )
  end
end
