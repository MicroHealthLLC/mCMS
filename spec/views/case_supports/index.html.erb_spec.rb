require 'rails_helper'

RSpec.describe "case_supports/index", type: :view do
  before(:each) do
    assign(:case_supports, [
      CaseSupport.create!(
        :user_id => 2,
        :case_id => 3,
        :first_name => "First Name",
        :middle_name => "Middle Name",
        :last_name => "Last Name",
        :case_support_type_id => 4,
        :note => "MyText"
      ),
      CaseSupport.create!(
        :user_id => 2,
        :case_id => 3,
        :first_name => "First Name",
        :middle_name => "Middle Name",
        :last_name => "Last Name",
        :case_support_type_id => 4,
        :note => "MyText"
      )
    ])
  end

  it "renders a list of case_supports" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Middle Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
