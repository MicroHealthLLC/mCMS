require "rails_helper"

RSpec.describe NoteTemplatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/note_templates").to route_to("note_templates#index")
    end

    it "routes to #new" do
      expect(:get => "/note_templates/new").to route_to("note_templates#new")
    end

    it "routes to #show" do
      expect(:get => "/note_templates/1").to route_to("note_templates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/note_templates/1/edit").to route_to("note_templates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/note_templates").to route_to("note_templates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/note_templates/1").to route_to("note_templates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/note_templates/1").to route_to("note_templates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/note_templates/1").to route_to("note_templates#destroy", :id => "1")
    end

  end
end
