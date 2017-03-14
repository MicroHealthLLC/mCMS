class TasksController < UserCasesController
  add_breadcrumb I18n.t('tasks'), :tasks_path
  before_action :set_task, only: [:link_plan, :add_plan, :show, :edit, :update, :destroy,
                                  :delete_sub_task_relation]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /tasks
  # GET /tasks.json
  def index
    respond_to do |format|
      format.html{}
      format.pdf{
        scope = Task.root
        scope = case params[:status_type]
                  when 'all' then scope.all_data
                  when 'opened' then scope.opened
                  when 'closed' then scope.closed
                  when 'flagged' then scope.flagged
                  else
                    scope.opened
                end
        scope = scope.include_enumerations.
            where('tasks.assigned_to_id = :user OR tasks.for_individual_id = :user', user:  User.current.id)
        @tasks = scope
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: TaskDatatable.new(view_context, options)
      }
    end
  end

  def my
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
    set_client_profile(@task)
    @notes = @task.task_notes
    @tasks = @task.sub_tasks
  end

  # GET /tasks/new
  def new
    if params[:plan_id]
      if params[:plan_id]
        @task = Task.new(user_id: User.current.id,
                         assigned_to_id: User.current_user.id,
                         for_individual_id: User.current.id,
                         related_to_id: params[:case_id],
                         related_to_type: 'Case')
        @task.plan_tasks.build(plan_id: params[:plan_id])
      end
    else
      @task = Task.new(user_id: User.current.id,
                       assigned_to_id: User.current_user.id,
                       for_individual_id: User.current.id,
                       sub_task_id: params[:sub_task_id],
                       related_to_id: params[:related_to],
                       related_to_type: params[:type])
    end


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
        set_link_to_appointment(@task)
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
    add_breadcrumb @task.to_s, @task
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
