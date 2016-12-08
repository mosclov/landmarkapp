require 'rails_helper'

RSpec.feature "Favorites", type: :feature do
  context "Favoriting a LandMark" do
    Steps "To sign up" do
      Given "I am on the landing page" do
        visit "/"
        click_link "Sign Up"
        expect(page).to have_content("Sign Up")
        fill_in "user_email", with: "a@a.com"
        fill_in "user_password", with: "asdfgh"
        fill_in "user_password_confirmation", with: "asdfgh"
        click_button("Sign up")
        expect(page).to have_content("Welcome a@a.com")
      end

      And "I can add a new landmark" do
        click_link "Create New Landmark!"
        fill_in "landmark_name", with: "Test Landmark"
        fill_in "landmark_description", with: "Landmark description"
        fill_in "landmark_address", with: "92101"
        fill_in "landmark_criteria", with: "Test criteria"
        attach_file "landmark_image", Rails.root + "app/assets/images/silverwing.jpeg"
        click_on "Create Landmark"
        expect(page).to have_content("Landmark was successfully created.")
        expect(page).to have_content("Test Landmark")
      end

      Then "I can favorite / Unfavorite from the landmark page" do
        click_button("Favorite")
        page.should have_no_content("Favorite")
        click_button("Unfavorite")
        page.should have_no_content("Unfavorite")
      end


      Then "I can favorite / Unfavorite from the Listings page" do
        click_link "Listings"
        expect(page).to have_content("Listing Landmarks")
        expect(page).to have_content("Test Landmark")
        click_button("Favorite")
        page.should have_no_content("Favorite")
        click_button("Unfavorite")
        page.should have_no_content("Unfavorite")
      end

      Then "I can favorite / Unfavorite from myprofile page" do
      click_link "myProfile"
      expect(page).to have_content("Welcome a@a.com")
      click_link("Favorites")
      expect(page).to have_content("Empty for now")
      # TODO Missing implementation of landmarks favorited and ability to
      # favorite / Unfavorite.
      end
    end #steps
  end #context
end # end of rspec
