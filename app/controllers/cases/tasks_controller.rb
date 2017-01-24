class TasksController < UserCasesController

  before_action :set_task, only: [:link_plan, :add_plan, :show, :edit, :update, :destroy,
                                  :delete_sub_task_relation]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.root.
        where(assigned_to: User.current).
        or(Task.root.where(for_individual: User.current) )
  end

  def my
    @tasks = Task.root.
        where(assigned_to: User.current).
        or(Task.root.where(for_individual: User.current) )
    render 'tasks/index'
  end

  def link_plan
    @plans = @task.plans
    @available_plans = @task.available_plans
  end
  

  def add_plan
    respond_to do |format|
      format.js{
        @plan_id = params[:plan_id]
        g = @task.plan_tasks.where(plan_id: @plan_id)
        if g.present?
          g.delete_all
        else
          @plan = Plan.find(@plan_id)
          @available_plans = @task.available_plans
          if @available_plans.include?(@plan)
            @task.plans<< @plan
          end
        end
      }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @notes = @task.task_notes
    @tasks = @task.sub_tasks
    if current_user.allowed_to?(:manage_roles) and @task.user
      session[:employee_id] = @task.user.id
      User.current = @task.user
    end
  end

  # GET /tasks/new
  def new
    @task = Task.new(user_id: User.current.id,
                     assigned_to_id: User.current.id,
                     for_individual_id: User.current.id,
                     sub_task_id: params[:sub_task_id],
                     related_to_id: params[:related_to],
                     related_to_type: params[:type])
  end

  # GET /tasks/1/edit
  def edit
    @note = TaskNote.new(user_id: User.current.id)
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @note = TaskNote.new(user_id: User.current.id)

    respond_to do |format|
      if @task.save
        format.html { redirect_to back_url, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to back_url, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_sub_task_relation
    @task.sub_task_id = nil
    @task.save
    redirect_to tasks_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(Task.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @task.can?(:edit_tasks, :manage_tasks, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @task.can?(:delete_tasks, :manage_tasks, :manage_roles)
  end

  def back_url
    if @task.case
      case_url(@task.case)
    else
      tasks_url
    end
  end

end
