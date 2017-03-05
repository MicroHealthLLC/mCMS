class CasesController < UserCasesController
  add_breadcrumb I18n.t(:cases), :cases_path


  before_action :set_case, only: [:new_assign_survey, :watchers, :new_assign, :show, :edit, :update, :destroy, :new_relation, :delete_sub_case_relation]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /cases
  # GET /cases.json
  def index
    respond_to do |format|
      format.html{}
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
    @cases        = @case.sub_cases
    @relations    = @case.relations

    @tasks        = @case.tasks
    @surveys      = @case.survey_cases
    @documents    = @case.documents
    @checklists   = @case.checklists#.map(&:checklist_template)
    @notes        = @case.case_notes
    @appointments = @case.appointments
    @needs        = @case.needs
    @plans        = @case.plans
    @goals        = @case.goals
    @jsignatures  = @case.jsignatures
    @enrollments  = @case.enrollments
    @referrals    = @case.referrals
    @teleconsults = @case.teleconsults
    @watchers     = @case.watchers.includes(:user=> :core_demographic)

    @case_supports = @case.case_supports.active
  end

  def watchers
    @watchers = @case.watchers.pluck :user_id
    if request.post?
      if params[:case_watcher]
        w = User.where(id: params[:case_watcher].map(&:to_i)).pluck :id
        w.each do |watcher|
          next if @watchers.include?(watcher)
          CaseWatcher.create(user_id: watcher, case_id: @case.id)
        end
      end
      deleted_watcher = @watchers - w
      @case.watchers.where(user_id: deleted_watcher).delete_all
      redirect_to case_url(@case)
    else
      @users = User.power_user.includes(:core_demographic)
    end

  end

  # GET /cases/new
  def new
    @case = Case.new(assigned_to_id: User.current.id,
                     subcase_id: params[:subcase_id], user_id: User.current.id)
  end

  # GET /cases/1/edit
  def edit
  end

  def new_assign
    if request.post?
      @checklist = ChecklistCase.new(params.require(:checklist_case).permit!)

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
  end

  def new_assign_survey
    if request.post?
      @survey = SurveyCase.new(params.require(:survey_case).permit!)
      if @survey.save
        redirect_to new_attempt_path(survey_id: @survey.survey.id, c: params[:controller], case_id: @case.id)
      else
        @surveys = Survey::Survey.order('name ASC') - Survey::Survey.where(id: SurveyCase.where(assigned_to_id: @case.id).pluck(:survey_id))
      end
    else
      @surveys = Survey::Survey.order('name ASC') - Survey::Survey.where(id: SurveyCase.where(assigned_to_id: @case.id).pluck(:survey_id))
      @survey = SurveyCase.new(assigned_to_id: @case.id)

    end
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
    @case.destroy
    respond_to do |format|
      format.html { redirect_to cases_url, notice: 'Case was successfully destroyed.' }
      format.json { head :no_content }
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
      @case_relation = CaseRelation.new(params.require(:case_relation).permit!)
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
  # Use callbacks to share common setup or constraints between actions.
  def set_case
    @case = Case.find(params[:id])
    add_breadcrumb @case.case.to_s, case_path(@case.case) if @case.case
    add_breadcrumb @case.to_s, case_path(@case)
  rescue ActiveRecord::RecordNotFound
    render_404
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

end
