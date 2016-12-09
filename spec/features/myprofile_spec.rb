require 'rails_helper'

RSpec.feature "myProfile", type: :feature do
  context "Signing up" do
    Steps "To sign up" do
      Given "I am on the landing page" do
        visit "/"
      end
        expect(page).to have_content("Sign Up")
      And "I can go to the sign up page" do
        click_link "Sign Up"
      end
      Then "I am taken to a sign up page" do
        expect(page).to have_content("Sign up")
      end
      And "I can fill out the sign up form" do
        fill_in "user_email", with: "a@a.com"
        fill_in "user_password", with: "asdfgh"
        fill_in "user_password_confirmation", with: "asdfgh"

      end
      Then "I can sign up do" do
        click_button("Sign up")
      end
      And "I am taken to my profile page" do
        expect(page).to have_content("Welcome! You have signed up successfully.")
        click_on "Create New Landmark"
        fill_in "landmark_name", with: "Cafe Chloe"
        fill_in "landmark_description", with: "Something"
        fill_in "landmark_address", with: "1550 Market St, San Diego CA"
        fill_in "landmark_website", with: "Test website"
        attach_file "landmark_image", Rails.root + "app/assets/images/silverwing.jpeg"
        click_on "Create Landmark"
        expect(page).to have_content("Landmark was successfully created.")
        click_link "myProfile"
        expect(page).to have_content("Cafe Chloe")
      end
      Then "I can click on the Favorites tab" do
        click_link "Favorites"
        click_link("Sign Out")
        expect(page).to have_content("Welcome!")
      end
    end #steps
  end #context


end # end of rspec
