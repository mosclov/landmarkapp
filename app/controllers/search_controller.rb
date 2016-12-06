class SearchController < ApplicationController

  def location_search
    #if the user has typed in a zipcode
    if !params[:zipcode].nil?
      #created this variable because @zipcode is used somewhere else
      @zipcode = params[:zipcode]
      #uses geocoder gem to find all landmarks within 10 miles of the given zipcode
      @landmarks = Landmark.near(params[:zipcode], 10, :order => false)
      #ALSO, if there are no landmarks within ten miles of that zip
      if @landmarks.length == 0
        #redirect to root and alert the user.
        flash[:notice] = "There are no landmarks in your area yet!"
        redirect_to '/'
      end #end of landmark count if
    #otherwise, if the user DID NOT input a zipcode
    else
      flash[:notice] = "There are no landmarks in your area yet!"
      redirect_to '/'
    end #end of zipcode existence if

  end #end of def location_search
end
