require_dependency "svg_edit/application_controller"

module SvgEdit
  class SvgController < ApplicationController
    before_action  :authenticate_user!
    def index
    end
  end
end
