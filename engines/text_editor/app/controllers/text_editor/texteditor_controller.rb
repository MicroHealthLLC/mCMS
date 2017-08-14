require_dependency "text_editor/application_controller"

module TextEditor
  class TexteditorController < ApplicationController
    before_action  :authenticate_user!
    def index
    end
  end
end
