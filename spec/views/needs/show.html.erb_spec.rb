require 'rails_helper'

RSpec.describe "needs/show", type: :view do
  before(:each) do
    @need = assign(:need, Need.create!(
      :need_enum_id => 2,
      :priority_id => 3,
      :need_status_id => 4,
      :description => "MyText",
      :user_id => 5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/5/)
  end
end
