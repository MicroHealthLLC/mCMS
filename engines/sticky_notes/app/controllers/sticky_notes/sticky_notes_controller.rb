# require_dependency "sticky_note/application_controller"

module StickyNotes
  class StickyNotesController < ApplicationController
    before_action  :authenticate_user!
    before_action :authorize

    def index
      respond_to do |format|
        format.html{
          @todos = StickyNotes::StickyNote.where(user_id: User.current.id).first_or_initialize
        }
      end
    end

    def save
      taskboard = StickyNotes::StickyNote.where(user_id: User.current.id).first_or_initialize
      taskboard.todos = params[:todos]
      taskboard.save

      render js: "saved= true"
    end
  end
end
