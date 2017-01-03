require 'rails_helper'

RSpec.describe "AppointmentCaptures", type: :request do
  describe "GET /appointment_captures" do
    it "works! (now write some real specs)" do
      get appointment_captures_path
      expect(response).to have_http_status(200)
    end
  end
end
