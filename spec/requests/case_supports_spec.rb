require 'rails_helper'

RSpec.describe "CaseSupports", type: :request do
  describe "GET /case_supports" do
    it "works! (now write some real specs)" do
      get case_supports_path
      expect(response).to have_http_status(200)
    end
  end
end
