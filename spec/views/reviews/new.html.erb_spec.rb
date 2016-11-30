require 'rails_helper'

RSpec.describe "reviews/new", type: :view do
  before(:each) do
    assign(:review, Review.new(
      :text => "MyText",
      :landmark => nil,
      :user => nil
    ))
  end

  it "renders new review form" do
    render

    assert_select "form[action=?][method=?]", reviews_path, "post" do

      assert_select "textarea#review_text[name=?]", "review[text]"

      assert_select "input#review_landmark_id[name=?]", "review[landmark_id]"

      assert_select "input#review_user_id[name=?]", "review[user_id]"
    end
  end
end
