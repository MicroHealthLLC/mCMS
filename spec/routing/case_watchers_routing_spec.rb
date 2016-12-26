require "rails_helper"

RSpec.describe CaseWatchersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/case_watchers").to route_to("case_watchers#index")
    end

    it "routes to #new" do
      expect(:get => "/case_watchers/new").to route_to("case_watchers#new")
    end

    it "routes to #show" do
      expect(:get => "/case_watchers/1").to route_to("case_watchers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/case_watchers/1/edit").to route_to("case_watchers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/case_watchers").to route_to("case_watchers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/case_watchers/1").to route_to("case_watchers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/case_watchers/1").to route_to("case_watchers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/case_watchers/1").to route_to("case_watchers#destroy", :id => "1")
    end

  end
end
