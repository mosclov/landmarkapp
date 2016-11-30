require 'rails_helper'

RSpec.describe Review, type: :model do
  it "should have a text, a user and a landmark" do
    rev = Review.new(text: "Hello")

    user = User.new(email: 'mrin@m.com', password: 'm')
    user.save

    landmark = Landmark.new(name: "Mrin")
    landmark.user = user
    landmark.save

    rev.landmark = landmark
    rev.user = user
    expect(rev.save).to be true
    expect(rev.user.email).to eq "mrin@m.com"


    new_rev = Review.find(rev.id)
    new_rev.user = user
    expect(new_rev.user.email). to eq "mrin@m.com"
    expect(new_rev.landmark.name). to eq "Mrin"
  end
end
