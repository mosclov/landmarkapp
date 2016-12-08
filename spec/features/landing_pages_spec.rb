require 'rails_helper'

RSpec.feature "LandingPages", type: :feature do
  def sign_up_and_create_landmark_and_sign_out
    click_link "Sign Up"
    fill_in "user_email", with: "a@a.com"
    fill_in "user_password", with: "asdfgh"
    fill_in "user_password_confirmation", with: "asdfgh"
    click_button("Sign up")
    click_on "Create New Landmark"
    fill_in "landmark_name", with: "Cafe Chloe"
    fill_in "landmark_description", with: "Something"
    fill_in "landmark_address", with: "1550 Market St, San Diego CA"
    fill_in "landmark_website", with: "Test website"
    attach_file "landmark_image", Rails.root + "app/assets/images/silverwing.jpeg"
    click_on "Create Landmark"
    click_link "Sign Out"
  end

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
      Then "I can click the Log In link" do
        click_link "Log In"
      end
      Then "I am taken to the Log in page" do
        expect(page).to have_content("Log In")
      end
      And "I can fill out the email and password field" do
        fill_in "user_email", with: "a@a.com"
        fill_in "user_password", with: "asdfgh"
      end
      Then "I can log in" do
        click_button "Log In"
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
      Then "I can click the Log In link" do
        click_link "Log In"
      end
      Then "I am taken to the Log in page" do
        expect(page).to have_content("Log In")
      end
      And "I can fill out the email and password field" do
        fill_in "user_email", with: "a@a.com"
        fill_in "user_password", with: "asdfg"
        click_button "Log In"
      end
      Then "I can see an error message" do
        expect(page).to have_content "Invalid Email or password."
      end

    end #steps

  end#context

  context "Viewing the website landmarks" do
    Steps "to view the landmarks and their users" do
      Given "that I am on the landing page" do
        visit "/"
        click_on 'Sign Up'
        fill_in 'user_email', with: 'm@m.com'
        fill_in 'user_password', with: 'mrinalini'
        fill_in 'user_password_confirmation', with: 'mrinalini'
        click_on 'Sign up'
        click_on "Create New Landmark"
        fill_in "landmark_name", with: "Cafe Chloe"
        fill_in "landmark_description", with: "Something"
        fill_in "landmark_address", with: "1550 Market St, San Diego CA"
        fill_in "landmark_website", with: "Test website"
        attach_file "landmark_image", Rails.root + "app/assets/images/silverwing.jpeg"
        click_on "Create Landmark"
        click_link "Sign Out"
      end
      And "I can click on the listings button" do
        click_link "Listings"
      end
      Then "I am taken to a page with the listing of the landmarks" do
        expect(page).to have_content "Listing Landmarks"
        expect(page).to have_content "Cafe Chloe"
        expect(page).to have_content "Something"
      end

      #Testing for landmarks list on welcome page next to map BY MRIN
      #Commented out because now it only appears if there is a star rating in the landmark -fg
      # And "I can see the landmark listings on the landing page too" do
      #   visit '/'
      #   expect(page).to have_content("Cafe Chloe")
      # end
    end #steps
  end #context
  context "returning to the Landing Page" do
    Steps "to return to the landing page" do
      Given "I am not on the landing page" do
        visit "/"
        click_link "Listings"
      end
      And "I can click on a 'LandMark' link" do
        click_link "LandMark"
      end
      Then "I am to taken to the landing page" do
        expect(page).to have_content "Welcome"
      end

    end #Steps

  end #context
  context "Going to my profile page" do
    Steps "to revisit my profile page" do
      Given "that I am a registered, logged in user" do
        visit "/"
        click_on 'Sign Up'
        fill_in 'user_email', with: 'm@m.com'
        fill_in 'user_password', with: 'mrinalini'
        fill_in 'user_password_confirmation', with: 'mrinalini'
        click_on 'Sign up'
        click_on "Create New Landmark"
        fill_in "landmark_name", with: "Cafe Chloe"
        fill_in "landmark_description", with: "Something"
        fill_in "landmark_address", with: "1550 Market St, San Diego CA"
        click_on "Create Landmark"
      end
      Then "I can click on my profile link" do
        click_link "myProfile"
      end
      And "I am taken back to my profile" do
        expect(page).to have_content "m@m.com"
      end
    end#Steps
  end#context

  context "Searching for landmarks by zipcode" do
    Steps "To search by zipcode" do
      Given "that I am on the landing page" do
        visit "/"
        click_on 'Sign Up'
        fill_in 'user_email', with: 'm@m.com'
        fill_in 'user_password', with: 'mrinalini'
        fill_in 'user_password_confirmation', with: 'mrinalini'
        click_on 'Sign up'
        click_on "Create New Landmark"
        fill_in "landmark_name", with: "Cafe Chloe"
        fill_in "landmark_description", with: "Something"
        fill_in "landmark_address", with: "2125 Westinghouse Street, San Diego, CA"
        fill_in "landmark_website", with: "Test website"
        attach_file "landmark_image", Rails.root + "app/assets/images/silverwing.jpeg"
        click_on "Create Landmark"
      end

      Then "I can type in a zipcode on the landing page" do
        visit '/'
        fill_in "zipcode", with: "92111"
        click_on "Landmarks Near Me"
      end

      And "I am taken to a page that shows me all landmarks within 10 miles of that zip" do
        expect(page).to have_content("Cafe Chloe")
      end
    end
  end
  context "Searching for a landmark" do
    Steps "to search for a landmark" do
      Given "I am on the landing page and there are saved landmarks" do
        visit "/"
        sign_up_and_create_landmark_and_sign_out
      end
      Then "I can see a search form" do
        expect(page).to have_selector("input[placeholder='Search']")
      end
      And "I can fill out the search" do
        fill_in "search", with: "something"
        click_on 'Submit'
      end
      Then "I am taking to a page with the matching landmarks" do
        expect(page).to have_content('Cafe Chloe')
      end

    end#steps
  end#context
  context "Search for a landmark that does not exist" do
    Steps "to search for a landmark that does not exist" do
      Given "I am on the landing page and there are saved landmarks" do
        visit "/"
        sign_up_and_create_landmark_and_sign_out
      end
      Then "I can see a search form" do
        expect(page).to have_selector("input[placeholder='Search']")
      end
      And "I can fill out the search" do
        fill_in "search", with: "blah"
        click_on 'Submit'
      end
      Then "I see a no matching landmarks flash message" do
        expect(page).to have_content "Please try again."
      end
    end #Steps
  end #context
  # context "getting map data" do
  #   Steps "check that a given landmark is in the list" do
  #     Given "I can see icons on the map" do
  #       visit "/"
  #       click_on 'Sign Up'
  #       fill_in 'user_email', with: 'a@a.a'
  #       fill_in 'user_password', with: 'andrew'
  #       fill_in 'user_password_confirmation', with: 'andrew'
  #       click_on 'Sign up'
  #       click_on "Create New Landmark"
  #       fill_in "landmark_name", with: "LEARN Sucka"
  #       fill_in "landmark_description", with: "Something"
  #       fill_in "landmark_address", with: "1550 Market St, San Diego CA"
  #       click_on "Create Landmark"
  #     end
  #     Then "My land mark is verified to be in json format" do
  #       visit "/landmarks/map_locations"
  #       expect(page).to have_content "LEARN Sucka"
  #     end
  #
  #   end
  #
  # end

end #feature
