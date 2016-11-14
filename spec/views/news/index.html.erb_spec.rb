require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    assign(:posts, [
      New.create!(
        :title => "Title",
        :summary => "Summary",
        :description => "MyText",
        :user_id => 2,
        :notes_count => 3
      ),
      New.create!(
        :title => "Title",
        :summary => "Summary",
        :description => "MyText",
        :user_id => 2,
        :notes_count => 3
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Summary".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
