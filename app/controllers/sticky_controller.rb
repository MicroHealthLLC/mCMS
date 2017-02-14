class StickyController < UserProfilesController

  def index
    respond_to do |format|
      format.html{
        @taskboards = TaskBoard.where(user_id: User.current.id).first
      }
    end
  end


  def save
    taskboard = TaskBoard.where(user_id: User.current.id).first_or_initialize
    taskboard.todos= params[:todos]
    taskboard.save

    render js: "saved= true"
  end
end
