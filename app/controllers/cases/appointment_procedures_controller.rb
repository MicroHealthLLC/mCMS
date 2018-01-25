class AppointmentProceduresController < ProtectForgeryApplication

  add_breadcrumb I18n.t(:appointments), :appointments_path
  before_action :set_appointment_procedure, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]



  # GET /appointment_procedures/1
  # GET /appointment_procedures/1.json
  def show
  end

  # GET /appointment_procedures/new
  def new
    @appointment = Appointment.find(params[:appointment_id])
    @appointment_procedure = AppointmentProcedure.new(user_id: User.current.id,
                                                      provider_id: User.current_user.id,
                                                      appointment_id: @appointment.id
    )
    set_breadcrumbs
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # GET /appointment_procedures/1/edit
  def edit
  end

  # POST /appointment_procedures
  # POST /appointment_procedures.json
  def create
    @appointment_procedure = AppointmentProcedure.new(appointment_procedure_params)
    @appointment = @appointment_procedure.appointment
    respond_to do |format|
      if @appointment_procedure.save
        format.html { redirect_to appointment_path(@appointment)+'#tabs-procedure', notice: 'Appointment procedure was successfully created.' }
        format.json { render :show, status: :created, location: @appointment_procedure }
      else
        format.html { render :new }
        format.json { render json: @appointment_procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointment_procedures/1
  # PATCH/PUT /appointment_procedures/1.json
  def update
    respond_to do |format|
      if @appointment_procedure.update(appointment_procedure_params)
        format.html { redirect_to appointment_path(@appointment)+'#tabs-procedure', notice: 'Appointment procedure was successfully updated.' }
      #  format.json { render :show, status: :ok, location: @appointment_procedure }
      else
        format.html { render :edit }
        format.json { render json: @appointment_procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointment_procedures/1
  # DELETE /appointment_procedures/1.json
  def destroy
    @appointment_procedure.destroy
    respond_to do |format|
      format.html { redirect_to appointment_path(@appointment)+'#tabs-procedure', notice: 'Appointment procedure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_appointment_procedure
    @appointment_procedure = AppointmentProcedure.find(params[:id])
    @appointment = @appointment_procedure.appointment

    set_breadcrumbs
    add_breadcrumb 'Procedures', appointment_path(@appointment)+'#tabs-procedure'
    add_breadcrumb @appointment_procedure, @appointment_procedure
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def set_breadcrumbs
    if @appointment.case
      add_breadcrumb @appointment.case, @appointment.case
      add_breadcrumb I18n.t(:appointments), case_path(@appointment.case) + '#tabs-appointments'
    else
      add_breadcrumb I18n.t(:appointments), :appointments_path
    end

    add_breadcrumb @appointment, appointment_path(@appointment)
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def appointment_procedure_params
    params.require(:appointment_procedure).permit(AppointmentProcedure.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @appointment.can?(:edit_appointments, :manage_appointments, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @appointment.can?(:delete_appointments, :manage_appointments, :manage_roles)
  end
end
