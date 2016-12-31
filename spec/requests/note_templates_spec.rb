require 'rails_helper'

RSpec.describe "NoteTemplates", type: :request do
  describe "GET /note_templates" do
    it "works! (now write some real specs)" do
      get note_templates_path
      expect(response).to have_http_status(200)
    end
  end
end
