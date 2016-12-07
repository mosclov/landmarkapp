class WelcomeController < ApplicationController

  def index
    @landmarks = Landmark.stars.paginate(:page => params[:page], :per_page => 5)
  end

end
