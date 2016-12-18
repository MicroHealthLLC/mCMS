require 'rails_helper'

RSpec.describe "user_insurances/show", type: :view do
  before(:each) do
    @user_insurance = assign(:user_insurance, UserInsurance.create!(
      :user_id => 2,
      :insurance_id => 3,
      :insurance_type_id => 4,
      :insurance_identifier => "Insurance Identifier",
      :note => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Insurance Identifier/)
    expect(rendered).to match(/MyText/)
  end
end
