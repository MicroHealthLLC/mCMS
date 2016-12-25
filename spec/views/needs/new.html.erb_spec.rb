require 'rails_helper'

RSpec.describe "needs/new", type: :view do
  before(:each) do
    assign(:need, Need.new(
      :need_enum_id => 1,
      :priority_id => 1,
      :need_status_id => 1,
      :description => "MyText",
      :user_id => 1
    ))
  end

  it "renders new need form" do
    render

    assert_select "form[action=?][method=?]", needs_path, "post" do

      assert_select "input#need_need_enum_id[name=?]", "need[need_enum_id]"

      assert_select "input#need_priority_id[name=?]", "need[priority_id]"

      assert_select "input#need_need_status_id[name=?]", "need[need_status_id]"

      assert_select "textarea#need_description[name=?]", "need[description]"

      assert_select "input#need_user_id[name=?]", "need[user_id]"
    end
  end
end
