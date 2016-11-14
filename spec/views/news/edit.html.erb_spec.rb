require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  before(:each) do
    @new = assign(:new, New.create!(
      :title => "MyString",
      :summary => "MyString",
      :description => "MyText",
      :user_id => 1,
      :notes_count => 1
    ))
  end

  it "renders the edit new form" do
    render

    assert_select "form[action=?][method=?]", new_path(@new), "post" do

      assert_select "input#new_title[name=?]", "new[title]"

      assert_select "input#new_summary[name=?]", "new[summary]"

      assert_select "textarea#new_description[name=?]", "new[description]"

      assert_select "input#new_user_id[name=?]", "new[user_id]"

      assert_select "input#new_notes_count[name=?]", "new[notes_count]"
    end
  end
end
