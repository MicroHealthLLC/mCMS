class CasesController < UserCasesController
  # add_breadcrumb I18n.t(:cases), :cases_path
  include ApplicationHelper

  # before_action :set_case_with_includes, only: []
  before_action :set_case, only: [:show, :timeline, :new_assign_survey, :watchers,
                                  :edit, :update, :new_assign,
                                  :destroy, :new_relation, :delete_sub_case_relation]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]
  before_action :authorize_view, only: [:show, :edit]

  # GET /cases
  # GET /cases.json
  def index
    respond_to do |format|
      format.html{}
      format.pdf{
        scope = Case
        scope = case params[:status_type]
                  when 'all' then scope.all_data
                  when 'opened' then scope.opened
                  when 'closed' then scope.closed
                  when 'flagged' then scope.flagged
                  else
                    scope.opened
                end
        scope = scope.include_enumerations
        scope = if User.current.can?(:manage_roles)
                  scope.where(assigned_to_id: User.current)
                else
                  scope.visible
                end
        @cases = scope
      }
      format.csv{ params[:length] = 500
      options = Hash.new
      options[:status_type] = params[:status_type]
      json = CaseDatatable.new(view_context, options).as_json
      send_data Case.to_csv(json[:data]), filename: "case-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:subcases] = false
        options[:status_type] = params[:status_type]
        render json: CaseDatatable.new(view_context,options)
      }
    end
  end

  def subcases
    respond_to do |format|
      format.html{}
      format.pdf{}
      format.json{
        options = Hash.new
        options[:subcases] = true
        options[:status_type] = params[:status_type]
        render json: CaseDatatable.new(view_context,options)
      }
    end
  end

  def all_files
    @appointment_files = Appointment.my_appointments.map(&:appointment_attachments)
    @document_files = Document.visible.map(&:document_attachments)
    @task_files = Task.
        where(assigned_to: User.current).
        or(Task.root.where(for_individual: User.current) ).map(&:task_attachments)
    @files = @appointment_files.flatten + @document_files.flatten + @task_files.flatten
  end

  # GET /cases/1
  # GET /cases/1.json
  def show
    set_client_profile(@case)

    set_models_permissions
  end


  def timeline
    @timeline = []
    @timeline << @case.sub_cases
    @timeline << @case.relations

    @timeline << @case.tasks
    @timeline << @case.documents
    @timeline << @case.case_notes
    @timeline << @case.appointments
    @timeline << @case.needs
    @timeline << @case.plans
    @timeline << @case.goals
    @timeline << @case.jsignatures
    @timeline << @case.enrollments
    @timeline << @case.referrals
    @timeline << @case.teleconsults
    @timeline << @case.transports
    @timeline << @case.case_supports.active
    @timeline << @case.worker_compensations
    @timeline << @case.job_apps
    @timeline.flatten!.compact!
    @timeline.sort_by!{|a| Time.now - a.updated_at }
    respond_to do |format|
      format.html{}
      format.js{}
    end
  end

  def watchers
    if request.post?
      @case_watcher = CaseWatcher.new(case_id: @case.id)
      @case_watcher.attributes = params.require(:case_watcher).permit(:user_id, :reason)
      if @case_watcher.save
        redirect_to case_url(@case)
      else
        @watchers = @case.watchers.pluck :user_id
        @users = User.power_user.includes(:core_demographic).references(:core_demographic).where.not(id: @watchers)
      end
    else
      @watchers = @case.watchers.pluck :user_id
      @case_watcher = CaseWatcher.new(case_id: @case.id)
      @users = User.power_user.includes(:core_demographic).references(:core_demographic).where.not(id: @watchers)
    end
    add_breadcrumb 'Case watchers', case_path(@case) + '#tabs-watcher'
  end

  # GET /cases/new
  def new
    @case = Case.new(assigned_to_id: User.current_user.id,
                     date_start: Date.today,
                     subcase_id: params[:subcase_id],
                     user_id: User.current.id)
    set_breadcrumbs
  end

  # GET /cases/1/edit
  def edit
    set_client_profile(@case)
    set_models_permissions
  end

  def new_assign
    if request.post?
      @checklist = ChecklistCase.new(params.require(:checklist_case).permit(ChecklistCase.safe_attributes))

      if @checklist.save
        set_link_to_appointment(@checklist)
        redirect_to checklist_case_path(@checklist)
      else
        @checklists = ChecklistTemplate.order('title ASC') #- ChecklistTemplate.where(id: ChecklistCase.where(assigned_to_id: @case.id).pluck(:checklist_template_id))
      end
    else
      @checklists = ChecklistTemplate.order('title ASC') #- ChecklistTemplate.where(id: ChecklistCase.where(assigned_to_id: @case.id).pluck(:checklist_template_id))
      @checklist = ChecklistCase.new(assigned_to_id: @case.id)
    end
    add_breadcrumb 'Checklists', case_path(@case) + '#tabs-checklists'
  end

  def new_assign_survey
    if request.post?
      @survey = SurveyCase.new(survey_case_params)
      if @survey.save
        redirect_to new_attempt_path(survey_id: @survey.survey.id, c: params[:controller], case_id: @case.id)
      else
        @surveys = Survey::Survey.order('name ASC') - Survey::Survey.where(id: SurveyCase.where(assigned_to_id: @case.id).pluck(:survey_id))
      end
    else
      @surveys = Survey::Survey.order('name ASC') - Survey::Survey.where(id: SurveyCase.where(assigned_to_id: @case.id).pluck(:survey_id))
      @survey = SurveyCase.new(assigned_to_id: @case.id)

    end
    add_breadcrumb 'Surveys', case_path(@case) + '#tabs-surveys'
  end

  # POST /cases
  # POST /cases.json
  def create
    @case = Case.new(case_params)
    @case.user_id =   User.current.id
    respond_to do |format|
      if @case.save
        format.html { redirect_to back_url, notice: 'Case was successfully created.' }
        format.json { render :show, status: :created, location: @case }
      else
        format.html { render :new }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cases/1
  # PATCH/PUT /cases/1.json
  def update
    respond_to do |format|
      if @case.update(case_params)
        format.html { redirect_to back_url, notice: 'Case was successfully updated.' }
        format.json { render :show, status: :ok, location: @case }
      else
        format.html { render :edit }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cases/1
  # DELETE /cases/1.json
  def destroy
    if @case.sub_cases.exists?
      flash[:error] = "Cannot delete this case because it has subcases attached"
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { head :no_content }
      end
    else
      @case.destroy
      respond_to do |format|
        format.html { redirect_to cases_url, notice: 'Case was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  end

  def delete_sub_case_relation
    root_case  = Case.find(@case.subcase_id) rescue nil
    @case.subcase_id = nil
    @case.save
    redirect_to root_case ? root_case : cases_url
  end

  def new_relation
    if request.post?
      @case_relation = CaseRelation.new(params.require(:case_relation).permit(CaseRelation.safe_attributes))
      case @case_relation.relation_type
        when 'Survey' then @case_relation.relation_id = params[:survey_id]
        when 'Task' then @case_relation.relation_id = params[:task_id]
        when 'Case' then @case_relation.relation_id = params[:case_id]
        else
      end

      if @case_relation.save
        redirect_to @case.case
      else
        @cases = Case.root.where(assigned_to_id: User.current.id ).pluck(:title, :id)
        @tasks = Task.where(assigned_to_id: User.current.id ).pluck(:title, :id)
        @surveys = Survey::Survey.includes(:survey_users).
            references(:survey_users).where("#{SurveyUser.table_name}.assigned_to_id = ?", User.current.id ).pluck(:name, :id)

      end
    else
      @cases = Case.root.where(assigned_to_id: User.current.id ).pluck(:title, :id)
      @tasks = Task.where(assigned_to_id: User.current.id ).pluck(:title, :id)
      @surveys = Survey::Survey.includes(:survey_users).
          references(:survey_users).where("#{SurveyUser.table_name}.assigned_to_id = ?", User.current.id ).pluck(:name, :id)

      @case_relation = CaseRelation.new(case_id: @case.id, relation_type: 'Case')
    end
  end

  def delete_relation
    a = CaseRelation.find(params[:id])
    a.destroy

    redirect_to :back
  end

  private

  def set_models_permissions
    @cases               = @case.sub_cases     if module_enabled?('subcases')
    @relations           = @case.relations

    @worker_compensations  = [] if module_enabled?( 'worker_compensations')  && can?(:manage_roles, :view_worker_compensations, :manage_worker_compensations)
    @job_apps              = [] if module_enabled?( 'job_applications')  && can?(:manage_roles, :view_job_applications, :manage_job_applications)

    @teleconsults        = []  if module_enabled?('teleconsults') && can?(:manage_roles, :view_teleconsults, :manage_teleconsults)
    @transports          = []  if module_enabled?('transports') && can?(:manage_roles, :view_transports, :manage_transports)
    @enrollments         = []  if module_enabled?('enrollments') && can?(:manage_roles, :view_enrollments, :manage_enrollments)

    @measurement_records = []  if module_enabled?('measurement_records')  && can?(:manage_roles, :view_measurement_records, :manage_measurement_records)
    @needs               = []  if module_enabled?('needs') && can?(:manage_roles, :view_needs, :manage_needs)
    @goals               = []  if module_enabled?('goals') && can?(:manage_roles, :view_goals, :manage_goals)

    @plans               = []  if module_enabled?('plans') && can?(:manage_roles, :view_plans, :manage_plans)
    @tasks               = []  if module_enabled?('tasks') && can?(:manage_roles, :view_tasks, :manage_tasks)
    @referrals           = []  if module_enabled?('referrals')  && can?(:manage_roles, :view_referrals, :manage_referrals)

    @case_supports       = []  if module_enabled?('case_support')  && can?(:manage_roles, :view_case_supports, :manage_case_supports)
    @documents           = []  if module_enabled?('documents') && can?(:manage_roles, :view_documents, :manage_documents)
    @appointments        = []  if module_enabled?('appointments') && can?(:manage_roles, :view_appointments, :manage_appointments)

    @jsignatures         = []  if module_enabled?('jsignatures') && can?(:manage_roles, :view_jsignatures, :manage_jsignatures)


    @checklists          = @case.checklists    if module_enabled?('checklists') && can?(:manage_roles, :view_checklists, :manage_checklists)
    @surveys             = @case.survey_cases  if module_enabled?('surveys') && can?(:manage_roles, :view_surveys, :manage_surveys)
    @notes               = @case.case_notes    if module_enabled?('notes') && can?(:manage_roles, :view_notes, :manage_notes)

    @case_organizations  = @case.case_organizations     if module_enabled?('case_organizations') && can?(:manage_roles, :view_case_managements, :manage_case_managements)

    @watchers            = @case.watchers.includes(:user=> :core_demographic) if module_enabled?('enrollments') && can?(:manage_roles, :view_case_watchers, :manage_case_watchers)

  end
  # Use callbacks to share common setup or constraints between actions.
  def set_case
    @case = Case.find(params[:id])
    set_breadcrumbs
    add_breadcrumb @case.to_s, case_path(@case)
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def set_breadcrumbs
    if @case.case
      add_breadcrumb @case.case.to_s, case_path(@case.case)
      add_breadcrumb 'SubCases', case_path(@case.case) + '#tabs-subcases'
    end

  end

  def set_case_with_includes
    @case = Case.where(id: params[:id]).
        includes(:sub_cases, :relations, :tasks, :survey_cases,
                 :documents,  :checklists,  :case_notes, :appointments , :needs,
                 :plans,  :goals, :jsignatures, :enrollments, :referrals, :teleconsults,
                 :transports, :measurement_records, :case_organizations).
        references(:sub_cases,  :relations, :tasks, :survey_cases,
                   :documents,  :checklists,  :case_notes, :appointments , :needs,
                   :plans,  :goals, :jsignatures, :enrollments, :referrals, :teleconsults,
                   :transports, :measurement_records, :case_organizations).first
    add_breadcrumb @case.case.to_s, case_path(@case.case) if @case.case
    add_breadcrumb @case.to_s, case_path(@case)
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def survey_case_params
    params.require(:survey_case).permit(SurveyCase.safe_attributes)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def case_params
    params.require(:case).permit(Case.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @case.can?(:edit_cases, :manage_cases, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @case.can?(:delete_cases, :manage_cases, :manage_roles)
  end

  def back_url
    @case.redirection
  end

  def authorize_view
    unless User.current_user.admin? or  User.current.organization == User.current_user.organization
      org = User.current_user.organization
      co = CaseOrganization.where(organization_id: org.try(:id)).where(case_id: User.current.cases.pluck(:id)).pluck(:case_id)
      unless @case.id.in?(co)
        render_403
      end
    end
  end

end
