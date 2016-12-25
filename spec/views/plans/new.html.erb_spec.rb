require 'rails_helper'

RSpec.describe "plans/new", type: :view do
  before(:each) do
    assign(:plan, Plan.new(
      :name => "MyString",
      :priority_type_id => 1,
      :plan_status_id => 1,
      :description => "MyText",
      :user_id => 1,
      :case_id => 1
    ))
  end

  it "renders new plan form" do
    render

    assert_select "form[action=?][method=?]", plans_path, "post" do

      assert_select "input#plan_name[name=?]", "plan[name]"

      assert_select "input#plan_priority_type_id[name=?]", "plan[priority_type_id]"

      assert_select "input#plan_plan_status_id[name=?]", "plan[plan_status_id]"

      assert_select "textarea#plan_description[name=?]", "plan[description]"

      assert_select "input#plan_user_id[name=?]", "plan[user_id]"

      assert_select "input#plan_case_id[name=?]", "plan[case_id]"
    end
  end
end
