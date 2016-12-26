require 'rails_helper'

RSpec.describe "case_watchers/index", type: :view do
  before(:each) do
    assign(:case_watchers, [
      CaseWatcher.create!(
        :user_id => 2,
        :case_id => 3
      ),
      CaseWatcher.create!(
        :user_id => 2,
        :case_id => 3
      )
    ])
  end

  it "renders a list of case_watchers" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
