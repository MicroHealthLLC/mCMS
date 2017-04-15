# require_dependency "kanban/application_controller"

module Kanban
  class ProjectsController < ApplicationController
    before_action  :authenticate_user!
    def index
      respond_to do |format|
        format.html{
          @projects = if User.current.admin?
                        Kanban::Project.pluck(:name)
                      else
                        User.current.projects.pluck(:name)
                      end
        }
        format.json do
          if params[:project_name]
            project = Kanban::Project.find_by(name: params[:project_name])
            if project
              if User.current.can?(:manage_roles) or User.current.project_users.pluck(:project_id).include?(project.id)
                User.current.update(last_project_used_id: project.id)
              end
            end
           end
          @project = Kanban::Project.find_by(id: User.current.last_project_used_id)
          json = if @project
                   @project.for_local_storage
                 else
                   last_project = User.current.projects.last
                   last_project ? last_project.for_local_storage : Kanban::Project.default_local_storage
                 end
          render json: {success: true, data: json}
        end
      end

    end

    def create
      respond_to do |format|
        format.json{
          project = Kanban::Project.new(name: params[:name], number_of_columns: params['numberOfColumns'])
          if project.save
            Kanban::ProjectUser.create(user_id: User.current.id, project_id: project.id)
            User.current.update(last_project_used_id: project.id)
            json = project.for_local_storage
            render json: {success: true, data: json}
          else
            render json: {success: false, errors: project.errors.full_messages.join('<br/>')}
          end
        }
      end
    end

    def update
      project = Kanban::Project.find_by(id: params[:project_id])
      project.name = params[:new_name]
      if project.save
        render json: {success: true}
      else
        render json: {success: false, errors: project.errors.full_messages.join('<br/>')}
      end

    end

    def destroy
      project = Kanban::Project.find_by(id: params[:project_id])
      project.destroy
      render json: {success: true}
    end
  end
end
