require 'rails_helper'

RSpec.feature "LandingPages", type: :feature do
  context "Landing page" do
    Steps "Going to landing page" do
      Given "I visit localhost 3000:" do
        visit "/"

      end
      Then "I am welcomed" do
        expect(page).to have_content("Welcome!")
      end
      Then "I can see mission statement" do
        expect(page).to have_content("Welcome to The Landmark Locator, your one stop shop for FUN!! Here you can find interesting    places to go and things to do based on location and various amenities.")
      end
    end #end of Steps
  end #end of context

  context "There is a map on the landing page" do
    Steps "Going to the landing page" do
      Given "I am on the landing page" do
        visit "/"
      end
      Then "I can see a map" do
        expect(page).to have
      end
    end #end of Steps
  end #end of context
end #end of RSpec
