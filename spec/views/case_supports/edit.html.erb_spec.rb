require 'rails_helper'

RSpec.describe "case_supports/edit", type: :view do
  before(:each) do
    @case_support = assign(:case_support, CaseSupport.create!(
      :user_id => 1,
      :case_id => 1,
      :first_name => "MyString",
      :middle_name => "MyString",
      :last_name => "MyString",
      :case_support_type_id => 1,
      :note => "MyText"
    ))
  end

  it "renders the edit case_support form" do
    render

    assert_select "form[action=?][method=?]", case_support_path(@case_support), "post" do

      assert_select "input#case_support_user_id[name=?]", "case_support[user_id]"

      assert_select "input#case_support_case_id[name=?]", "case_support[case_id]"

      assert_select "input#case_support_first_name[name=?]", "case_support[first_name]"

      assert_select "input#case_support_middle_name[name=?]", "case_support[middle_name]"

      assert_select "input#case_support_last_name[name=?]", "case_support[last_name]"

      assert_select "input#case_support_case_support_type_id[name=?]", "case_support[case_support_type_id]"

      assert_select "textarea#case_support_note[name=?]", "case_support[note]"
    end
  end
end
