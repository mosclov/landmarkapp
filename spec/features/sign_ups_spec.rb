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
end
