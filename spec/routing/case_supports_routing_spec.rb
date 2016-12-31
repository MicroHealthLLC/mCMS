require "rails_helper"

RSpec.describe CaseSupportsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/case_supports").to route_to("case_supports#index")
    end

    it "routes to #new" do
      expect(:get => "/case_supports/new").to route_to("case_supports#new")
    end

    it "routes to #show" do
      expect(:get => "/case_supports/1").to route_to("case_supports#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/case_supports/1/edit").to route_to("case_supports#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/case_supports").to route_to("case_supports#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/case_supports/1").to route_to("case_supports#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/case_supports/1").to route_to("case_supports#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/case_supports/1").to route_to("case_supports#destroy", :id => "1")
    end

  end
end
