# require_dependency "kanban/application_controller"

module Kanban
  class ColumnsController < ApplicationController
    before_action  :authenticate_user!
    before_action  :authorize
    before_filter :find_project
    before_filter :find_column, only: [:create, :update, :destroy]
    def index
    end

    def create
      @new_column = Kanban::Column.new(project_id: @project.id)
      @new_column.attributes = params[:create].permit(:name, :settings)
      @new_column.position = @column.position.to_i + 1
      if @new_column.save
        render json: {success: true, id: @new_column.id}
      else
        render json: {success: false, errors: @new_column.errors.full_messages.join('<br/>')}
      end

    end

    def update
      updates = params[:updates]
      @column.name = updates[:name]
      @column.settings = updates.permit!
      if @column.save
        render json: {success: true}
      else
        render json: {success: false, errors: @column.errors.full_messages.join('<br/>')}
      end
    end

    def destroy
      @column.destroy
      render json: {success: true}
    end

    private

    def find_project
      @project = Kanban::Project.find(params[:project_id])
    end

    def find_column
      @column = @project.columns.find(params[:column_id])
    end
  end

end
