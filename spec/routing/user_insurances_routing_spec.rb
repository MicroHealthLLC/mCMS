require "rails_helper"

RSpec.describe UserInsurancesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_insurances").to route_to("user_insurances#index")
    end

    it "routes to #new" do
      expect(:get => "/user_insurances/new").to route_to("user_insurances#new")
    end

    it "routes to #show" do
      expect(:get => "/user_insurances/1").to route_to("user_insurances#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/user_insurances/1/edit").to route_to("user_insurances#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/user_insurances").to route_to("user_insurances#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/user_insurances/1").to route_to("user_insurances#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/user_insurances/1").to route_to("user_insurances#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_insurances/1").to route_to("user_insurances#destroy", :id => "1")
    end

  end
end
