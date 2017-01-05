class AppointmentCapturesController < ApplicationController
  before_action  :authenticate_user!
  before_action :set_appointment_capture, only: [:show, :edit, :update, :destroy]

  before_action :authorize, only: [:new, :create]
  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /appointment_captures/1
  # GET /appointment_captures/1.json
  def show
  end

  # GET /appointment_captures/new
  def new
    @appointment = Appointment.find(params[:appointment_id])
    @appointment_capture = AppointmentCapture.new(user_id: User.current.id,
                                                  appointment_id: @appointment.id
    )
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # GET /appointment_captures/1/edit
  def edit
  end

  # POST /appointment_captures
  # POST /appointment_captures.json
  def create
    @appointment_capture = AppointmentCapture.new(appointment_capture_params)

    respond_to do |format|
      if @appointment_capture.save
        format.html { redirect_to @appointment_capture, notice: 'Appointment capture was successfully created.' }
        format.json { render :show, status: :created, location: @appointment_capture }
      else
        format.html { render :new }
        format.json { render json: @appointment_capture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointment_captures/1
  # PATCH/PUT /appointment_captures/1.json
  def update
    respond_to do |format|
      if @appointment_capture.update(appointment_capture_params)
        format.html { redirect_to @appointment_capture, notice: 'Appointment capture was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment_capture }
      else
        format.html { render :edit }
        format.json { render json: @appointment_capture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointment_captures/1
  # DELETE /appointment_captures/1.json
  def destroy
    @appointment_capture.destroy
    respond_to do |format|
      format.html { redirect_to appointment_captures_url, notice: 'Appointment capture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_appointment_capture
    @appointment_capture = AppointmentCapture.find(params[:id])
    @appointment = @appointment_capture.appointment
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def appointment_capture_params
    params.require(:appointment_capture).permit(AppointmentCapture.safe_attributes)
  end

  def authorize
    super('appointments', 'new')
  end

  def authorize_edit
    raise Unauthorized unless @appointment.can?(:edit_appointments, :manage_appointments, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @appointment.can?(:delete_appointments, :manage_appointments, :manage_roles)
  end

end
