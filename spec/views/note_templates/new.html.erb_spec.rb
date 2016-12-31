require 'rails_helper'

RSpec.describe "note_templates/new", type: :view do
  before(:each) do
    assign(:note_template, NoteTemplate.new(
      :title => "MyString",
      :note => "MyText"
    ))
  end

  it "renders new note_template form" do
    render

    assert_select "form[action=?][method=?]", note_templates_path, "post" do

      assert_select "input#note_template_title[name=?]", "note_template[title]"

      assert_select "textarea#note_template_note[name=?]", "note_template[note]"
    end
  end
end
