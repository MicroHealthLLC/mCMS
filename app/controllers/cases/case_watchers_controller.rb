class CaseWatchersController < UserCasesController

  # GET /case_watchers
  # GET /case_watchers.json
  def index
    @case_watchers = CaseWatcher.visible.
        includes(:case).paginate(page: params[:page], per_page: 25)
  end
end
