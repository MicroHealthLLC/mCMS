require 'rails_helper'

RSpec.describe "needs/index", type: :view do
  before(:each) do
    assign(:needs, [
      Need.create!(
        :need_enum_id => 2,
        :priority_id => 3,
        :need_status_id => 4,
        :description => "MyText",
        :user_id => 5
      ),
      Need.create!(
        :need_enum_id => 2,
        :priority_id => 3,
        :need_status_id => 4,
        :description => "MyText",
        :user_id => 5
      )
    ])
  end

  it "renders a list of needs" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
