# require_dependency "mindmap/application_controller"

module Mindmap
  class MindmapController < ApplicationController
    before_action  :authenticate_user!
    def index
      @mindmap = Mindmap::MindMap.where( user_id: User.current.id).first_or_initialize
    end

    def save
      @mindmap = Mindmap::MindMap.where( user_id: User.current.id).first_or_initialize
      @mindmap.content = params[:content]
      @mindmap.save
      render json: {success: true}
    end
  end
end
