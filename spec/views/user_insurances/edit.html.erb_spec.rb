require 'rails_helper'

RSpec.describe "user_insurances/edit", type: :view do
  before(:each) do
    @user_insurance = assign(:user_insurance, UserInsurance.create!(
      :user_id => 1,
      :insurance_id => 1,
      :insurance_type_id => 1,
      :insurance_identifier => "MyString",
      :note => "MyText"
    ))
  end

  it "renders the edit user_insurance form" do
    render

    assert_select "form[action=?][method=?]", user_insurance_path(@user_insurance), "post" do

      assert_select "input#user_insurance_user_id[name=?]", "user_insurance[user_id]"

      assert_select "input#user_insurance_insurance_id[name=?]", "user_insurance[insurance_id]"

      assert_select "input#user_insurance_insurance_type_id[name=?]", "user_insurance[insurance_type_id]"

      assert_select "input#user_insurance_insurance_identifier[name=?]", "user_insurance[insurance_identifier]"

      assert_select "textarea#user_insurance_note[name=?]", "user_insurance[note]"
    end
  end
end
