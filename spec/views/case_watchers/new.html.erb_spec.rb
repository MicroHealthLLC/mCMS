require 'rails_helper'

RSpec.describe "case_watchers/new", type: :view do
  before(:each) do
    assign(:case_watcher, CaseWatcher.new(
      :user_id => 1,
      :case_id => 1
    ))
  end

  it "renders new case_watcher form" do
    render

    assert_select "form[action=?][method=?]", case_watchers_path, "post" do

      assert_select "input#case_watcher_user_id[name=?]", "case_watcher[user_id]"

      assert_select "input#case_watcher_case_id[name=?]", "case_watcher[case_id]"
    end
  end
end
