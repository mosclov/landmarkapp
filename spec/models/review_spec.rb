require 'rails_helper'

RSpec.describe Review, type: :model do
  it "should have a text, a user and a landmark" do
    rev = Review.new(text: "Hello")

    user = User.new(email: 'mrin@m.com', password: 'm')
    user.save

    landmark = Landmark.new(name: "Cafe Chloe",
                      description: "Feels like Paris in the middle of San Diego!",
                          address: '721 Ninth Ave, San Diego, CA 92101',
                         website: 'Test website',
                            image: Rack::Test::UploadedFile.new('app/assets/images/silverwing.jpeg')
                            )

    landmark.user = user
    landmark.save

    rev.landmark = landmark
    rev.user = user
    expect(rev.save).to be true
    expect(rev.user.email).to eq "mrin@m.com"


    new_rev = Review.find(rev.id)
    new_rev.user = user
    expect(new_rev.user.email). to eq "mrin@m.com"
    expect(new_rev.landmark.name). to eq "Cafe Chloe"
  end
end
