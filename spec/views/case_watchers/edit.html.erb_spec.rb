require 'rails_helper'

RSpec.describe "case_watchers/edit", type: :view do
  before(:each) do
    @case_watcher = assign(:case_watcher, CaseWatcher.create!(
      :user_id => 1,
      :case_id => 1
    ))
  end

  it "renders the edit case_watcher form" do
    render

    assert_select "form[action=?][method=?]", case_watcher_path(@case_watcher), "post" do

      assert_select "input#case_watcher_user_id[name=?]", "case_watcher[user_id]"

      assert_select "input#case_watcher_case_id[name=?]", "case_watcher[case_id]"
    end
  end
end
