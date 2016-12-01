require 'rails_helper'

RSpec.feature "CreateLandmarks", type: :feature do

  context 'creating a new landmark' do

    Steps 'To log in and upload a new landmark' do
      Given 'I am on the landing page' do
        visit '/'
        click_on 'Sign Up'
        fill_in 'user_email', with: 'm@m.com'
        fill_in 'user_password', with: 'mrinalini'
        fill_in 'user_password_confirmation', with: 'mrinalini'
        click_on 'Sign up'
      end
      And 'I am taken to my profile where I can see a button' do
        expect(page).to have_content('m@m.com')
        click_on "Create New Landmark"
      end
      Then 'I can fill out a form to create a new landmark with image' do
        fill_in "landmark_name", with: "Cafe Chloe"
        fill_in "landmark_description", with: "Something"
        fill_in "landmark_address", with: "1550 Market St, San Diego CA"
        fill_in "landmark_criteria", with: "Test criteria"
        attach_file "landmark_image", Rails.root + "app/assets/images/silverwing.jpeg"

        click_on "Create Landmark"
      end

      #TODO
      # WILL TEST AFTER MY PROFILE LINK HAS BEEN ADDED TO NAVBAR
      And "I can see all my landmarks" do

        visit '/users/' + User.first.id.to_s
        expect(page).to have_content("Cafe Chloe")
        expect(page).to have_button("Edit")

      end

      And "I can alter my uploaded landmarks" do
        expect(page).to have_button("Edit")
        expect(page).to have_button("Delete")

      end
    end #end of steps
  end # end of context



end
