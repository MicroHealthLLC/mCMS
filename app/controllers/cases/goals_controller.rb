class GoalsController <  UserCasesController
  add_breadcrumb I18n.t(:goals), :goals_path
  before_action :set_goal, only: [:link_need, :add_need, :links, :add_plan, :show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /goals
  # GET /goals.json
  def index
    scope =  User.current.can?(:manage_roles) ? Goal.where(assigned_to_id: User.current.id) : Goal.visible
    scope = case params[:status_type]
              when 'all' then scope.all_data
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.opened
            end

    @goals = scope
  end

  # GET /goals/1
  # GET /goals/1.json
  def show
    if current_user.allowed_to?(:manage_roles) and @goal.user
      session[:employee_id] = @goal.user.id
      User.current = @goal.user
    end
    @plans = @goal.plans
    @tasks = @plans.map(&:tasks).flatten.uniq
  end

  def links
    @plans = @goal.plans
    @available_plans = @goal.available_plans
  end

  def link_need
    @needs = @goal.needs
    @available_needs = @goal.available_needs
  end

  def add_plan
    respond_to do |format|
      format.js{
        @plan_id = params[:plan_id]
        g = @goal.goal_plans.where(plan_id: @plan_id)
        if g.present?
          g.delete_all
        else
          @plan = Plan.find(@plan_id)
          @available_plans = @goal.available_plans
          if @available_plans.include?(@plan)
            @goal.plans<< @plan
          end
        end
      }
    end
  end

  def add_need
    respond_to do |format|
      format.js{
        @ne-ed_id = params[:need_id]
        g = @goal.need_goals.where(need_id: @need_id)
        if g.present?
          g.delete_all
        else
          @need = Need.find(@need_id)
          @available_needs = @goal.available_needs
          if @available_needs.include?(@need)
            @goal.need_goals<< NeedGoal.new(goal_id: @goal.id, need_id: @need.id)
          end
        end
      }
    end
  end

  # GET /goals/new
  def new
    @goal = Goal.new(user_id: User.current.id,
                     assigned_to_id: User.current_user.id,
                     case_id: params[:case_id])
    if params[:need_id]
      @goal.need_goals.build(need_id: params[:need_id])
    end
  end

  # GET /goals/1/edit
  def edit
  end

  # POST /goals
  # POST /goals.json
  def create
    @goal = Goal.new(goal_params)

    respond_to do |format|
      if @goal.save
        set_link_to_appointment(@goal)
        format.html { redirect_to @goal, notice: 'Goal was successfully created.' }
        format.json { render :show, status: :created, location: @goal }
      else
        format.html { render :new }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goals/1
  # PATCH/PUT /goals/1.json
  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to @goal, notice: 'Goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @goal }
      else
        format.html { render :edit }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy
    @goal.destroy
    respond_to do |format|
      format.html { redirect_to goals_url, notice: 'Goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_goal
    @goal = Goal.find(params[:id])
    @case = @goal.case
    add_breadcrumb @goal, goal_path(@goal)
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def goal_params
    params.require(:goal).permit(Goal.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @goal.can?(:edit_goals, :manage_goals, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @goal.can?(:delete_goals, :manage_goals, :manage_roles)
  end

end
