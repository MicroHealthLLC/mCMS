require 'rails_helper'

RSpec.describe "note_templates/show", type: :view do
  before(:each) do
    @note_template = assign(:note_template, NoteTemplate.create!(
      :title => "Title",
      :note => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
