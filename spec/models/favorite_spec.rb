require 'rails_helper'

RSpec.describe Favorite, type: :model do
  it "should have user and a landmark" do
    user = User.new(email: 'blah', password: 'mrin')
    landmark = Landmark.new(name: "Cafe Chloe",
                            description: "Feels like Paris in the middle of San Diego!",
                            address: '721 Ninth Ave, San Diego, CA 92101',
                            website: 'Test website',
                            image: Rack::Test::UploadedFile.new('app/assets/images/silverwing.jpeg')
                            )
    user.save
    landmark.user = user
    expect(landmark.save).to be true

    fav_land = Favorite.new
    fav_land.user = user
    fav_land.landmark = landmark
    expect(fav_land.save).to be true
    expect(fav_land.user.email).to eq 'blah'
    expect(fav_land.landmark.name).to eq 'Cafe Chloe'
  end
end
