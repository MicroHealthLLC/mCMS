class CaseWatchersController < ApplicationController
  # GET /case_watchers
  # GET /case_watchers.json
  def index
    @case_watchers = CaseWatcher.where(user_id: User.current.id).
        includes(:case).paginate(page: params[:page], per_page: 25)
  end
end
