require "rails_helper"

RSpec.describe AppointmentCapturesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/appointment_captures").to route_to("appointment_captures#index")
    end

    it "routes to #new" do
      expect(:get => "/appointment_captures/new").to route_to("appointment_captures#new")
    end

    it "routes to #show" do
      expect(:get => "/appointment_captures/1").to route_to("appointment_captures#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/appointment_captures/1/edit").to route_to("appointment_captures#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/appointment_captures").to route_to("appointment_captures#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/appointment_captures/1").to route_to("appointment_captures#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/appointment_captures/1").to route_to("appointment_captures#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/appointment_captures/1").to route_to("appointment_captures#destroy", :id => "1")
    end

  end
end
