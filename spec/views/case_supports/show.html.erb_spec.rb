require 'rails_helper'

RSpec.describe "case_supports/show", type: :view do
  before(:each) do
    @case_support = assign(:case_support, CaseSupport.create!(
      :user_id => 2,
      :case_id => 3,
      :first_name => "First Name",
      :middle_name => "Middle Name",
      :last_name => "Last Name",
      :case_support_type_id => 4,
      :note => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Middle Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/MyText/)
  end
end
