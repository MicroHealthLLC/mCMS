class PlansController < UserCasesController

  before_action :set_plan, only: [:links, :add_action, :link_goal, :add_goal,  :show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:links, :add_action, :edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /plans
  # GET /plans.json
  def index
    add_breadcrumb I18n.t('plans'), :plans_path
    options = Hash.new
    options[:status_type] = params[:status_type]
    options[:show_case] = params[:show_case]
    options[:case_id] = params[:case_id]
    options[:appointment_id] = params[:appointment_id]
    if params[:case_id]
      @case = Case.find params[:case_id]
    end
    if params[:appointment_id]
      @appointment = Appointment.find params[:appointment_id]
    end
    options[:appointment_id] = params[:appointment_id]
    respond_to do |format|
      format.html{  }
      format.js{ render 'application/index' }
      format.pdf{}
      format.csv{
        options[:show_case] = 'true'
        params[:length] = 500
        json = PlanDatatable.new(view_context, options).as_json
        send_data Plan.to_csv(json[:data]), filename: "Plans-#{Date.today}.csv"
      }
      format.json{
        render json: PlanDatatable.new(view_context,options)
      }
    end
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    set_client_profile(@plan)
    @tasks = @plan.tasks
    @measurement_records = @plan.measurement_records
  end

  def links
    @tasks = @plan.tasks
    @available_actions = @plan.available_tasks
  end

  def add_action
    respond_to do |format|
      format.js{
        @task_id = params[:task_id]
        g = @plan.plan_tasks.where(task_id: @task_id)
        if g.present?
          g.delete_all
        else
          @task = Task.find(@task_id)
          @available_actions = @plan.available_tasks
          if @available_actions.include?(@task)
            @plan.plan_tasks<< PlanTask.new(task_id: @task.id, plan_id: @plan.id)
          end
        end
      }
    end
  end

  def link_goal
    @goals = @plan.goals
    @available_goals = @plan.available_goals
  end

  def add_goal
    respond_to do |format|
      format.js{
        @goal_id = params[:goal_id]
        g = @plan.goal_plans.where(goal_id: @goal_id)
        if g.present?
          g.delete_all
        else
          @goal = Goal.find(@goal_id)
          @available_goals = @plan.available_goals
          if @available_goals.include?(@goal)
            @plan.goal_plans<< GoalPlan.new(goal_id: @goal.id, plan_id: @plan.id)
          end
        end
      }
    end
  end
  # GET /plans/new
  def new
    @plan = Plan.new(user_id: User.current.id,
                     assigned_to_id: User.current_user.id,
                     date_start: Date.today,
                     case_id: params[:case_id])
    if params[:goal_id]
      @plan.goal_plans.build(goal_id: params[:goal_id])
    end

    if @plan.case
      add_breadcrumb @plan.case, @plan.case
      add_breadcrumb I18n.t('plans'), case_path(@plan.case) + '#tabs-plans'
    else
      add_breadcrumb I18n.t('plans'), :plans_path
    end
  end

  # GET /plans/1/edit
  def edit
    @tasks = @plan.tasks
    @measurement_records = @plan.measurement_records

    @goals = @plan.goals
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)

    respond_to do |format|
      if @plan.save
        set_link_to_appointment(@plan)
        format.html { redirect_to @plan, notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    @tasks = @plan.tasks
    @measurement_records = @plan.measurement_records
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to back_index_case_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_plan
    @plan = Plan.find(params[:id])
    @case = @plan.case

    if @plan.case
      add_breadcrumb @plan.case, @plan.case
      add_breadcrumb I18n.t('plans'), case_path(@plan.case) + '#tabs-plans'
    else
      add_breadcrumb I18n.t('plans'), :plans_path
    end

    add_breadcrumb @plan.to_s, @plan
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def plan_params
    params.require(:plan).permit(Plan.safe_attributes)
  end
  def authorize_edit
    raise Unauthorized unless @plan.can?(:edit_plans, :manage_plans, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @plan.can?(:delete_plans, :manage_plans, :manage_roles)
  end
end
