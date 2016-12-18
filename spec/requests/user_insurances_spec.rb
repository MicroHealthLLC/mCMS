require 'rails_helper'

RSpec.describe "UserInsurances", type: :request do
  describe "GET /user_insurances" do
    it "works! (now write some real specs)" do
      get user_insurances_path
      expect(response).to have_http_status(200)
    end
  end
end
