require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'expecting User.current to be not_recorded' do
      get :index
      expect(User.current.id).to eq(nil)
    end
  end

  describe "User admin Logged in" do
    before(:each) do
      admin_user = User.where(admin: true).first
      sign_in(admin_user)
    end

    it "allows authenticated access" do
      get :index
      expect(response).to be_success
    end

    it "The User is an admin" do
      expect(User.current.admin).to eq(true)
    end
  end

end
