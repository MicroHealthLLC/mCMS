class CaseWatchersController < UserCasesController

  before_filter :set_case_watcher, only: [:show, :update, :edit, :destroy]
  # GET /case_watchers
  # GET /case_watchers.json
  def index
    add_breadcrumb I18n.t('watchers'), :case_watchers_path
    case_ids = Case.root.where('assigned_to_id= ? OR user_id= ?', User.current.id,  User.current.id ).pluck(:id)

    @case_watchers = CaseWatcher.where(case_id: case_ids).
        includes(:case).paginate(page: params[:page], per_page: 25)
  end

  def edit
    @watchers = @case.watchers.pluck :user_id
    @users = User.power_user.includes(:core_demographic).references(:core_demographic).where.not(id: @watchers) +  [@case_watcher.user]
    @users = @users.compact
  end

  def show

  end

  def update
    @case_watcher.update(params.require(:case_watcher).permit(:user_id, :reason))
    redirect_to :back
  end

  def destroy
    @case_watcher.destroy
    redirect_to :back
  end

  private

  def set_case_watcher
    @case_watcher = CaseWatcher.find(params[:id])
    @case = @case_watcher.case
    add_breadcrumb @case, @case
    add_breadcrumb 'Case watchers', case_path(@case) + '#tabs-watcher'
    add_breadcrumb @case_watcher.user, @case_watcher
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
