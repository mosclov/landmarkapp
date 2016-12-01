class WelcomeController < ApplicationController
  def index
    @landmarks = Landmark.all
  end
end
