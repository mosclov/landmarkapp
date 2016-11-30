require 'rails_helper'

RSpec.describe "reviews/edit", type: :view do
  before(:each) do
    @review = assign(:review, Review.create!(
      :text => "MyText",
      :landmark => nil,
      :user => nil
    ))
  end

  it "renders the edit review form" do
    render

    assert_select "form[action=?][method=?]", review_path(@review), "post" do

      assert_select "textarea#review_text[name=?]", "review[text]"

      assert_select "input#review_landmark_id[name=?]", "review[landmark_id]"

      assert_select "input#review_user_id[name=?]", "review[user_id]"
    end
  end
end
