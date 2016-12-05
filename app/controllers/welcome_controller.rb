class WelcomeController < ApplicationController
  def index
    @landmarks = Landmark.paginate(:page => params[:page], :per_page => 10)
  end

end
