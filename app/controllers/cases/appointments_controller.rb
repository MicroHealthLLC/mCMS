class AppointmentsController < UserCasesController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.includes(:user=> :core_demographic).my_appointments.paginate(page: params[:page], per_page: 25)
  end

  def my
    @appointments = Appointment.includes(:user=> :core_demographic).my_appointments.paginate(page: params[:page], per_page: 25)
    render 'appointments/index'
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    if current_user.allowed_to?(:manage_roles) and @appointment.user
      session[:employee_id] = @appointment.user.id
      User.current = @appointment.user
    end
    @case =  @appointment.case
    update_rails = @appointment.updated_at
    if @case
      @tasks       = @case.tasks.where(updated_at: update_rails)
      @surveys     = @case.survey_cases.where(updated_at: update_rails)
      @documents   = @case.documents.where(updated_at: update_rails)
      @checklists  = @case.checklists.where(updated_at: update_rails).map(&:checklist_template)
      @notes       = @case.case_notes.where(updated_at: update_rails)
      @appointments= @case.appointments.where(updated_at: update_rails).where.not(id: @appointment.id)
      @needs       = @case.needs.where(updated_at: update_rails)
      @plans       = @case.plans.where(updated_at: update_rails)
      @goals       = @case.goals.where(updated_at: update_rails)
      @watchers    = @case.watchers.where(updated_at: update_rails).includes(:user=> :core_demographic)
      @case_supports = @case.case_supports.where(updated_at: update_rails)
    end
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new(user_id: User.current.id,
                                   related_to_id: params[:related_to])
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.with_who = User.find(params[:appointment][:with_who_id]) rescue nil

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    @appointment.with_who = User.find(params[:appointment][:with_who_id]) rescue nil

    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.includes(:appointment_notes, :user=> :core_demographic).
        find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def appointment_params
    params.require(:appointment).permit(Appointment.safe_attributes)
  end
  
  def authorize_edit
    raise Unauthorized unless @appointment.can?(:edit_appointments, :manage_appointments, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @appointment.can?(:delete_appointments, :manage_appointments, :manage_roles)
  end

end
