class CaseWatchersController < UserCasesController

  # GET /case_watchers
  # GET /case_watchers.json
  def index
    case_ids = Case.root.where('assigned_to_id= ? OR user_id= ?', User.current.id,  User.current.id ).pluck(:id)

    @case_watchers = CaseWatcher.where(case_id: case_ids).
        includes(:case).paginate(page: params[:page], per_page: 25)
  end
end
