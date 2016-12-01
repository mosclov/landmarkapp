require 'rails_helper'

RSpec.feature "Reviews", type: :feature do
  context "Leaving reviews for landmarks" do
    Steps "Adding reviews to the landmark page" do
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

      And "I can leave a review for the landmark that I click on" do
        find(".list-group-item").click
        fill_in "review[text]", with: "My first landmark was awesome"
        click_on "Create Review"
      end

      Then "I can see the review I added below the landmark" do
        expect(page).to have_content("My first landmark was awesome")
      end
    end #end of steps
  end #end of context
end
