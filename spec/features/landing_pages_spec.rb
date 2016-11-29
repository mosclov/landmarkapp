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
      And "I am taken to my profile page" do
        expect(page).to have_content("Welcome! You have signed up successfully.")
        expect(page).to_not have_content('Sign Up')
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

    Then "I can see a log out link" do
        expect(page).to have_content("Sign Out")
      end

      Then "I can log out!" do
        click_link "Sign Out"
      end
      And "I see a successful sign out message" do
        expect(page).to have_content "Signed out successfully."
        expect(page).to_not have_content('Sign Out')
      end


    end#steps
  end#context
  context "Signing In" do
    Steps "To sign in" do
      Given "I am a registered user" do
        visit "/"
        click_link "Sign Up"
        fill_in "user_email", with: "a@a.com"
        fill_in "user_password", with: "asdfgh"
        fill_in "user_password_confirmation", with: "asdfgh"
        click_button("Sign up")
        click_link "Sign Out"
      end
      Then "I can click the Sign In link" do
        click_link "Sign In"
      end
      Then "I am taken to the Log in page" do
        expect(page).to have_content("Log in")
      end
      And "I can fill out the email and password field" do
        fill_in "user_email", with: "a@a.com"
        fill_in "user_password", with: "asdfgh"
      end
      Then "I can log in" do
        click_button "Log in"
      end
      And "I am taken to my profile page displaying my email and a successful message" do
        expect(page).to have_content "a@a.com"
        expect(page).to have_content "Signed in successfully."
      end

    end#steps
  end#context

  context "Registering with incorrect credentials" do
    Steps "to unsuccessfully register" do
      Given "I am on the landing page" do
        visit "/"
      end
      Then "I can click the Sign Up link" do
        click_link "Sign Up"
      end
      Then "I am taken to the Sign up page and can see a form" do
        expect(page).to have_content "Sign up"
      end
      And "I can fill out the sign up form" do
        fill_in "user_email", with: "a@a.com"
        fill_in "user_password", with: "asdfgh"
        fill_in "user_password_confirmation", with: "hg"
        click_button "Sign up"
      end

      Then "I am taken to a page with an error message" do
        expect(page).to have_content "1 error prohibited this user from being saved:"
      end
    end #steps
  end #context
  context "Signing in with incorrect credentials" do
    Steps "to unsuccessfully sign in" do
      Given "I a registered user on the landing page" do
        visit "/"
        click_link "Sign Up"
        fill_in "user_email", with: "a@a.com"
        fill_in "user_password", with: "asdfgh"
        fill_in "user_password_confirmation", with: "asdfgh"
        click_button("Sign up")
        click_link "Sign Out"
      end
      Then "I can click the Sign In link" do
        click_link "Sign In"
      end
      Then "I am taken to the Log in page" do
        expect(page).to have_content("Log in")
      end
      And "I can fill out the email and password field" do
        fill_in "user_email", with: "a@a.com"
        fill_in "user_password", with: "asdfg"
        click_button "Log in"
      end
      Then "I can see an error message" do
        expect(page).to have_content "Invalid Email or password."
      end

    end #steps

  end#context


end #feature
