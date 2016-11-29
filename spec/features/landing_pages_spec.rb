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
    end
  end

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
      And "I am taken to the landing page" do
        expect(page).to have_content("Welcome! You have signed up successfully.")
      end


    end #steps
  end #context

  context "logging out" do
    Steps "To log out a logged in user" do
      Given "I am logged in" do
        visit "/"
        click_link "Sign Up"
        fill_in "user_email", with: "a@a.com"
        fill_in "user_password", with: "asdfgh"
        fill_in "user_password_confirmation", with: "asdfgh"
        click_button("Sign up")
      end#given

      And "I can no longer see a 'sign up' link" do
        expect(page).to_not have_content('Sign up')
      end

      Then "I can see a log out link" do
        expect(page).to have_content("Log Out")
      end

      Then "I can log out!" do
        click_link "Log Out"
      end


    end#steps
  end#context



end #feature
