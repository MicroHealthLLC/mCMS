require 'rails_helper'

RSpec.describe "goals/new", type: :view do
  before(:each) do
    assign(:goal, Goal.new(
      :name => "MyString",
      :priority_type_id => 1,
      :goal_status_id => 1,
      :description => "MyText",
      :user_id => 1,
      :case_id => 1
    ))
  end

  it "renders new goal form" do
    render

    assert_select "form[action=?][method=?]", goals_path, "post" do

      assert_select "input#goal_name[name=?]", "goal[name]"

      assert_select "input#goal_priority_type_id[name=?]", "goal[priority_type_id]"

      assert_select "input#goal_goal_status_id[name=?]", "goal[goal_status_id]"

      assert_select "textarea#goal_description[name=?]", "goal[description]"

      assert_select "input#goal_user_id[name=?]", "goal[user_id]"

      assert_select "input#goal_case_id[name=?]", "goal[case_id]"
    end
  end
end
