class AppointmentDispositionsController < ProtectForgeryApplication
  # add_breadcrumb I18n.t(:appointments), :appointments_path
  before_action :set_appointment_disposition, only: [:show, :edit, :update, :destroy]
  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /appointment_dispositions/1
  # GET /appointment_dispositions/1.json
  def show
  end

  # GET /appointment_dispositions/new
  def new
    @appointment = Appointment.find(params[:appointment_id])
    @appointment_disposition = AppointmentDisposition.new(user_id: User.current.id,
                                                          appointment_id: @appointment.id
    )
    set_breadcrumbs
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # GET /appointment_dispositions/1/edit
  def edit
  end

  # POST /appointment_dispositions
  # POST /appointment_dispositions.json
  def create
    @appointment_disposition = AppointmentDisposition.new(appointment_disposition_params)
    @appointment = @appointment_disposition.appointment
    respond_to do |format|
      if @appointment_disposition.save
        format.html { redirect_to   appointment_path(@appointment)+'#tabs-disposition', notice: 'Appointment disposition was successfully created.' }
        format.json { render :show, status: :created, location: @appointment_disposition }
      else
        format.html { render :new }
        format.json { render json: @appointment_disposition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointment_dispositions/1
  # PATCH/PUT /appointment_dispositions/1.json
  def update
    respond_to do |format|
      if @appointment_disposition.update(appointment_disposition_params)
        format.html { redirect_to  appointment_path(@appointment)+'#tabs-disposition', notice: 'Appointment disposition was successfully updated.' }
      #  format.json { render :show, status: :ok, location: @appointment_disposition }
      else
        format.html { render :edit }
        format.json { render json: @appointment_disposition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointment_dispositions/1
  # DELETE /appointment_dispositions/1.json
  def destroy
    @appointment_disposition.destroy
    respond_to do |format|
      format.html { redirect_to appointment_path(@appointment)+'#tabs-disposition', notice: 'Appointment disposition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_appointment_disposition
    @appointment_disposition = AppointmentDisposition.find(params[:id])
    @appointment = @appointment_disposition.appointment
    set_breadcrumbs
    add_breadcrumb 'Dispositions', appointment_path(@appointment)+'#tabs-disposition'
    add_breadcrumb @appointment_disposition.to_s, appointment_disposition_path(@appointment_disposition)
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
  def appointment_disposition_params
    params.require(:appointment_disposition).permit(AppointmentDisposition.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @appointment.can?(:edit_appointments, :manage_appointments, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @appointment.can?(:delete_appointments, :manage_appointments, :manage_roles)
  end
end
