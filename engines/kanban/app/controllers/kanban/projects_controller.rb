# require_dependency "kanban/application_controller"

module Kanban
  class ProjectsController < ApplicationController
    before_action  :authenticate_user!

    before_action :find_project, only: [:update, :destroy]
    def index
      respond_to do |format|
        format.html{}
        format.json do
          if params[:project_name]
            project = Kanban::Project.find_by(name: params[:project_name])
            if project
              if User.current.can?(:manage_roles) or User.current.project_users.pluck(:project_id).include?(project.id)
                User.current.last_project_used_id=project.id
                User.current.save(validate: false)
              end
            end
           end
          @project = Kanban::Project.find_by(id: User.current.last_project_used_id) || User.current.projects.last
          unless @project
            if User.current.can?(:manage_roles)
              @project = Kanban::Project.last
            end
          end
          json =  @project ? @project.for_local_storage : Kanban::Project.default_local_storage
          projects =  if User.current.can?(:manage_roles)
                        Kanban::Project.where.not(name: @project.try(:name) )
                      else
                        User.current.projects.where.not(name: @project.try(:name))
                      end
          projects.each do |p|
            json['kanbans'].merge!(p.name => {})
          end
          render json: {success: true, data: json}
        end
      end

    end

    def manage_users
      @project = Kanban::Project.find_by(id: User.current.last_project_used_id)
      if request.post?
        @project.project_users.where.not(user_id: params[:users]).delete_all
        params[:user].each do |user_id|
          @project.project_users.where(user_id: user_id).first_or_create
        end
        redirect_to '/kanban'
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
      @project.name = params[:new_name]
      if @project.save
        render json: {success: true}
      else
        render json: {success: false, errors: @project.errors.full_messages.join('<br/>')}
      end

    end

    def destroy
      @project.destroy
      render json: {success: true}
    end

    private

    def find_project
      @project = Kanban::Project.find_by(id: params[:project_id])
    end
  end
end
