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
    login_admin
    it "should have a current_user" do
      expect(@admin.id).to_not eq(nil)
    end

    it "The User is an admin" do
      get :index
      expect(@admin.admin).to eq(true)
    end
  end

end
