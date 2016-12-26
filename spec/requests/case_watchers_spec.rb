require 'rails_helper'

RSpec.describe "CaseWatchers", type: :request do
  describe "GET /case_watchers" do
    it "works! (now write some real specs)" do
      get case_watchers_path
      expect(response).to have_http_status(200)
    end
  end
end
