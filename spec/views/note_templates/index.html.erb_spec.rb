require 'rails_helper'

RSpec.describe "note_templates/index", type: :view do
  before(:each) do
    assign(:note_templates, [
      NoteTemplate.create!(
        :title => "Title",
        :note => "MyText"
      ),
      NoteTemplate.create!(
        :title => "Title",
        :note => "MyText"
      )
    ])
  end

  it "renders a list of note_templates" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
