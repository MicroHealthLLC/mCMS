require 'rails_helper'

RSpec.describe "case_watchers/show", type: :view do
  before(:each) do
    @case_watcher = assign(:case_watcher, CaseWatcher.create!(
      :user_id => 2,
      :case_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
