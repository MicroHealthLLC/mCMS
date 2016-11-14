require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  before(:each) do
    @new = assign(:new, New.create!(
      :title => "Title",
      :summary => "Summary",
      :description => "MyText",
      :user_id => 2,
      :notes_count => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Summary/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
