require 'rails_helper'

RSpec.describe Landmark, type: :model do
  it "should have a name, description, address and user" do
    land_mark = Landmark.new(name: "Cafe Chloe", description: "Feels like Paris in the middle of San Diego!", address: '721 Ninth Ave, San Diego, CA 92101')
    user = User.new(email: 'mrin@sin.com', password: 'mrin')
    user.save
    land_mark.user = user

    expect(land_mark.save).to be true

    landm_ark = Landmark.find_by_name("Cafe Chloe")
    expect(landm_ark.description).to eq "Feels like Paris in the middle of San Diego!"
  end
end
