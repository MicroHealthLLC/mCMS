# require_dependency "kanban/application_controller"

module Kanban
  class CardsController < ApplicationController
    before_action  :authenticate_user!
    before_filter :find_project, only: :create
    before_filter :find_column, only: :create

    before_filter :find_card, except: [:create, :index]

    def index
    end

    def create
      card = Kanban::Card.new(project_id: @project.id, column_id: @column.id)
      card.attributes = params[:card].permit(:name, :description, :color)
      if card.save
        render json: {success: true, id: card.id, data: card.to_json }
      else
        render json: {success: false, errors: card.errors.full_messages.join('<br/>')}
      end
    rescue
      render json: {success: false, errors: e.message}
    end

    def update
      @card.attributes = params.require(:updates).permit(:name, :description, :color)
      if @card.save
        render json: {success: true }
      else
        render json: {success: false, errors: @card.errors.full_messages.join('<br/>')}
      end
    end

    def change_column
      @card.column_id = params[:column_id]
      if @card.save
        render json: {success: true }
      else
        render json: {success: false, errors: @card.errors.full_messages.join('<br/>')}
      end
    end

    def archive
      @card.is_archived = true
      @card.archived_on = Time.now
      if @card.save
        render json: {success: true }
      else
        render json: {success: false, errors: @card.errors.full_messages.join('<br/>')}
      end
    end

    def unarchive
      @card.is_archived = false
      @card.archived_on = nil
      if @card.save
        render json: {success: true }
      else
        render json: {success: false, errors: @card.errors.full_messages.join('<br/>')}
      end
    end

    def destroy
      @card.destroy
      render json: {success: true }
    end

    private

    def find_project
      @project = Kanban::Project.find(params[:project_id])
    end

    def find_column
      @column = @project.columns.find(params[:column_id])
    end

    def find_card
      @card = Kanban::Card.find(params[:card_id])
    end
  end

end
