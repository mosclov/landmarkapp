require 'rails_helper'

RSpec.feature "CreateLandmarks", type: :feature do
 context 'creating a new landmark' do
    Steps 'To log in and upload a new landmark' do
      Given 'I am on the landing page' do
        visit '/'
        click_on 'Sign Up'
        fill_in 'Email', with: 'm@m.com'
        fill_in 'Password', with: 'mrinalini'
        fill_in 'Password confirmation', with: 'mrinalini'
        click_on 'Sign up'
      end
      And 'I am taken to my profile where I can see a button' do
        expect(page).to have_content('m@m.com')
        click_on "Create New Landmark"
      end
      Then 'I can fill out a form to create a new landmark' do
        fill_in "Name", with: "Cafe Chloe"
        fill_in "Description", with: "Something"
        fill_in "Address", with: "1550 Market St, San Diego CA"
        click_on "Create Landmark"
      end
      #TODO
      # WILL TEST AFTER MY PROFILE LINK HAS BEEN ADDED TO NAVBAR
      And "I can see all my landmarks" do
        visit '/users/' + User.first.id.to_s
        expect(page).to have_content("Cafe Chloe")
        expect(page).to have_content("Edit")

      end

      And "I can alter my uploaded landmarks" do
        expect(page).to have_content("Show")
        expect(page).to have_content("Edit")
        expect(page).to have_content("Destroy")
      end
    end #end of steps
  end # end of context
end
