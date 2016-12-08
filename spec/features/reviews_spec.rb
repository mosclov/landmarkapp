require 'rails_helper'

RSpec.feature "Reviews", type: :feature do
  context "Leaving reviews for landmarks" do
    Steps "Adding reviews my own landmark" do
      Given "I am a registered user who has logged in successfully" do
        visit '/'
        click_on 'Sign Up'
        fill_in 'Email', with: 'm@m.com'
        fill_in 'Password', with: 'mrinalini'
        fill_in 'Password confirmation', with: 'mrinalini'
        click_on 'Sign up'
        expect(page).to have_content('m@m.com')
      end

      And "I have created a landmark" do
        click_on "Create New Landmark"
        fill_in "Name", with: "Cafe Chloe"
        fill_in "Description", with: "Something"
        fill_in "Address", with: "1550 Market St, San Diego CA"
        attach_file "landmark_image", Rails.root + "app/assets/images/silverwing.jpeg"
        expect{
          click_button 'Create Landmark'
        }.to change(Landmark, :count).by(1)
      end

      Then "I can go to the listings page with all landmarks" do
        visit '/landmarks'
        expect(page).to have_content("Cafe Chloe")
      end

      And "I cannot review a landmark that I have created" do
        expect(page).to_not have_content("Review this landmark")
      end

      # Then "I can see the review I added below the landmark" do
      #   expect(page).to have_content("My first landmark was awesome")
      # end
    end #end of steps

    Steps "Leaving reviews for other's landmarks" do
      Given "A user signs up and creates a landmark" do
        visit '/'
        click_link "Sign Up"
        fill_in "user_email", with: "a@a.com"
        fill_in "user_password", with: "asdfgh"
        fill_in "user_password_confirmation", with: "asdfgh"
        click_button("Sign up")
        click_on "Create New Landmark"
        fill_in "landmark_name", with: "Cafe Chloe"
        fill_in "landmark_description", with: "Something"
        fill_in "landmark_address", with: "1550 Market St, San Diego CA"
        fill_in "landmark_criteria", with: "Test criteria"
        attach_file "landmark_image", Rails.root + "app/assets/images/silverwing.jpeg"
        click_on "Create Landmark"
        click_link "Sign Out"
      end

      Then "I log in" do
        click_on 'Sign Up'
        fill_in 'Email', with: 'm@m.com'
        fill_in 'Password', with: 'mrinalini'
        fill_in 'Password confirmation', with: 'mrinalini'
        click_on 'Sign up'
        expect(page).to have_content('m@m.com')
      end

      Then "I can create a landmark" do
        click_on "Create New Landmark"
        fill_in "Name", with: "Cafe Chhhloe"
        fill_in "Description", with: "Something"
        fill_in "Address", with: "1550 Market St, San Diego CA"
        attach_file "landmark_image", Rails.root + "app/assets/images/silverwing.jpeg"
        expect{
          click_button 'Create Landmark'
        }.to change(Landmark, :count).by(1)
      end

      Then "I can go to the listings page with all landmarks" do
        visit '/landmarks'
        expect(page).to have_content("Cafe Chloe")
        expect(page).to have_content("Cafe Chhhloe")
        click_on "Cafe Chloe"
      end

      And "I can leave a review" do
        fill_in 'review[text]', with: "Awesome"
        click_on "Create Review"
      end

      Then "I can see my review on that page" do
        expect(page).to have_content("Awesome")
      end

    end #end of steps
  end #end of context
end
