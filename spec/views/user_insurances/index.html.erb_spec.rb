require 'rails_helper'

RSpec.describe "user_insurances/index", type: :view do
  before(:each) do
    assign(:user_insurances, [
      UserInsurance.create!(
        :user_id => 2,
        :insurance_id => 3,
        :insurance_type_id => 4,
        :insurance_identifier => "Insurance Identifier",
        :note => "MyText"
      ),
      UserInsurance.create!(
        :user_id => 2,
        :insurance_id => 3,
        :insurance_type_id => 4,
        :insurance_identifier => "Insurance Identifier",
        :note => "MyText"
      )
    ])
  end

  it "renders a list of user_insurances" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Insurance Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
