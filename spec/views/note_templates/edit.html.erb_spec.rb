require 'rails_helper'

RSpec.describe "note_templates/edit", type: :view do
  before(:each) do
    @note_template = assign(:note_template, NoteTemplate.create!(
      :title => "MyString",
      :note => "MyText"
    ))
  end

  it "renders the edit note_template form" do
    render

    assert_select "form[action=?][method=?]", note_template_path(@note_template), "post" do

      assert_select "input#note_template_title[name=?]", "note_template[title]"

      assert_select "textarea#note_template_note[name=?]", "note_template[note]"
    end
  end
end
