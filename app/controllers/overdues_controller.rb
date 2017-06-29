class OverduesController < ProtectForgeryApplication
  before_action :authenticate_user!
  before_action :authorize
  def index
  end

  def case_overdue
    scope = Case
    scope = scope.include_enumerations
    scope = if User.current.can?(:manage_roles)
              scope.where(assigned_to_id: User.current)
            else
              scope.visible
            end
    scope = case params[:type]
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.all_data.where('date_due <= ?', Date.today)
            end
    @cases = scope
  end

  def appointment_overdue
    scope = Appointment
    scope = case params[:type]
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.all_data.where('end_time <= ?', Date.today)
            end
    @appointments = scope.include_enumerations.
        includes(:user=> :core_demographic).
        references(:user=> :core_demographic).
        my_appointments
  end

  def need_overdue
    scope =  User.current.can?(:manage_roles) ? Need.where(assigned_to_id: User.current.id) : Need.visible
    scope = case params[:type]
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.all_data.where('date_due <= ?', Date.today)
            end
    @needs = scope
  end

  def goal_overdue
    scope =  User.current.can?(:manage_roles) ? Goal.where(assigned_to_id: User.current.id) : Goal.visible
    scope = scope.all_data
    scope = scope.where('date_due <= ?', Date.today)
    @goals = scope
  end

  def plan_overdue
    scope = User.current.can?(:manage_roles) ? Plan.where(assigned_to_id: User.current.id) : Plan.visible
    scope = case params[:type]
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.all_data.where('date_due <= ?', Date.today)
            end
    @plans = scope
  end

  def action_overdue
    scope = Task.root
    scope = case params[:type]
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.all_data.where('tasks.date_due <= ?', Date.today)
            end
    scope = scope.include_enumerations.
        where('tasks.assigned_to_id = :user OR tasks.for_individual_id = :user', user:  User.current.id)
    @tasks = scope
  end

  private

  def authorize
    render_403 unless User.current.can?(:manage_roles)
  end
end
