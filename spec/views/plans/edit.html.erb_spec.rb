require 'rails_helper'

RSpec.describe "plans/edit", type: :view do
  before(:each) do
    @plan = assign(:plan, Plan.create!(
      :name => "MyString",
      :priority_type_id => 1,
      :plan_status_id => 1,
      :description => "MyText",
      :user_id => 1,
      :case_id => 1
    ))
  end

  it "renders the edit plan form" do
    render

    assert_select "form[action=?][method=?]", plan_path(@plan), "post" do

      assert_select "input#plan_name[name=?]", "plan[name]"

      assert_select "input#plan_priority_type_id[name=?]", "plan[priority_type_id]"

      assert_select "input#plan_plan_status_id[name=?]", "plan[plan_status_id]"

      assert_select "textarea#plan_description[name=?]", "plan[description]"

      assert_select "input#plan_user_id[name=?]", "plan[user_id]"

      assert_select "input#plan_case_id[name=?]", "plan[case_id]"
    end
  end
end
