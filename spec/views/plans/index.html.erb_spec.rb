require 'rails_helper'

RSpec.describe "plans/index", type: :view do
  before(:each) do
    assign(:plans, [
      Plan.create!(
        :name => "Name",
        :priority_type_id => 2,
        :plan_status_id => 3,
        :description => "MyText",
        :user_id => 4,
        :case_id => 5
      ),
      Plan.create!(
        :name => "Name",
        :priority_type_id => 2,
        :plan_status_id => 3,
        :description => "MyText",
        :user_id => 4,
        :case_id => 5
      )
    ])
  end

  it "renders a list of plans" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
