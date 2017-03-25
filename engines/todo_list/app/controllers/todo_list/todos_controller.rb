module TodoList
  class TodosController < ApplicationController
    before_action  :authenticate_user!

    # GET /todos
    def index
      respond_to do |format|
        format.html{
          @todos = TodoList::Todo.where(user_id: User.current.id).first_or_initialize
        }
      end
    end

    def save
      taskboard = TodoList::Todo.where(user_id: User.current.id).first_or_initialize
      taskboard.todos = params[:todos]
      taskboard.save

      render js: "saved= true"
    end
  end
end
