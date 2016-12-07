require 'rails_helper'

RSpec.feature "Sign up", type: :feature do
  context 'Signing up as a user' do
    Steps 'To sign up' do
      Given 'I am on the sign up page' do
        visit 'users/sign_up'
      end
      Then 'I can fill out a registration form' do
        fill_in 'Email', with: 'm@m.com'
        fill_in 'Password', with: 'mrinalini'
        fill_in 'Password confirmation', with: 'mrinalini'
        click_on 'Sign up'
      end
      And 'I am taken to my profile page' do
        expect(page).to have_content('m@m.com')
      end
    end #end of steps
  end # end of context

  context 'Following users' do
    Steps 'To follow an exisiting user' do
      Given 'I have signed up and logged out' do
        visit '/'
        click_on 'Sign Up'
        fill_in 'user_email', with: 'm@m.com'
        fill_in 'user_password', with: 'mrinalini'
        fill_in 'user_password_confirmation', with: 'mrinalini'
        click_on 'Sign up'
        click_on "Create New Landmark"
        fill_in "landmark_name", with: "Cafe Chloe"
        fill_in "landmark_description", with: "Something"
        fill_in "landmark_address", with: "1550 Market St, San Diego CA"
        fill_in "landmark_criteria", with: "Test criteria"
        attach_file "landmark_image", Rails.root + "app/assets/images/silverwing.jpeg"
        click_on "Create Landmark"
        click_on 'Sign Out'
      end
      And 'another user signs up' do
        click_on 'Sign Up'
        fill_in 'user_email', with: 'm@mmmm.com'
        fill_in 'user_password', with: 'mrimmmnalini'
        fill_in 'user_password_confirmation', with: 'mrimmmnalini'
        click_on 'Sign up'
      end
      Then 'the other user can go to my profile and follow me' do
      visit '/'
      click_on "Cafe Chloe"
      click_on 'm@m.com'
      click_on 'Follow'
      end
      And 'They can also unfollow me' do
        click_on 'Unfollow'
      end
    end #end of steps
  end # end of context
end
