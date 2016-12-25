require 'rails_helper'

RSpec.describe "goals/edit", type: :view do
  before(:each) do
    @goal = assign(:goal, Goal.create!(
      :name => "MyString",
      :priority_type_id => 1,
      :goal_status_id => 1,
      :description => "MyText",
      :user_id => 1,
      :case_id => 1
    ))
  end

  it "renders the edit goal form" do
    render

    assert_select "form[action=?][method=?]", goal_path(@goal), "post" do

      assert_select "input#goal_name[name=?]", "goal[name]"

      assert_select "input#goal_priority_type_id[name=?]", "goal[priority_type_id]"

      assert_select "input#goal_goal_status_id[name=?]", "goal[goal_status_id]"

      assert_select "textarea#goal_description[name=?]", "goal[description]"

      assert_select "input#goal_user_id[name=?]", "goal[user_id]"

      assert_select "input#goal_case_id[name=?]", "goal[case_id]"
    end
  end
end
