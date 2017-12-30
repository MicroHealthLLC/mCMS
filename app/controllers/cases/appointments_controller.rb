class AppointmentsController < UserCasesController

  before_action :set_appointment, only: [:edit, :update, :destroy]
  before_action :set_appointment_with_includes, only: [:show, :cms_form]
  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    add_breadcrumb I18n.t(:appointments), :appointments_path

    options = Hash.new
    options[:status_type] = params[:status_type]
    options[:show_case] = params[:show_case]
    options[:case_id] = params[:case_id]
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
      format.pdf{
        scope = Appointment
        scope = scope.filter_status params[:status_type]
        @appointments = scope.include_enumerations.
            includes(:user=> :core_demographic).
            references(:user=> :core_demographic).
            my_appointments
      }
      format.csv{
        options[:show_case] = 'true'
        params[:length] = 500
        json = AppointmentDatatable.new(view_context, options).as_json
        send_data Appointment.to_csv(json[:data]), filename: "Appointment-#{Date.today}.csv"
      }
      format.json{
        render json: AppointmentDatatable.new(view_context,options)
      }
    end
  end

  def calendar
    date = params[:start_date] ? Date.strptime(params[:start_date]) : Date.today
    @meetings = Appointment.all_data.my_appointments.
        where('( date >= :start_date AND date <= :end_date) OR ( date <= :end_date AND end_time >= :start_date)',
              start_date: date.beginning_of_month,
              end_date: date.end_of_month
        )
  end

  def my
    render 'appointments/index'
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    set_client_profile(@appointment)
    @case =  @appointment.case
    @billings =  @appointment.billings
    # update_rails = @appointment.updated_at.to_date
    @appointment_links = @appointment.appointment_links.includes(:linkable)
    @jsignatures= @appointment.jsignatures
    @cases       = @appointment_links.where(linkable_type: 'Case').map(&:linkable)

    @checklists  = @appointment_links.where(linkable_type: 'ChecklistCase').map(&:linkable)
    @notes       = @appointment_links.where(linkable_type: 'Note').map(&:linkable)
    @appointments= @appointment_links.where(linkable_type: 'Appointment').map(&:linkable)

  end

  def cms_form
    hash = @appointment.get_cmf_form_data
    # Filling PDF
    pdftk = PdfForms.new('/usr/bin/pdftk')
    file_name = "#{Rails.root}/claim-form.pdf"
    path = "public/claim-forms"
    unless File.directory?(path)
      FileUtils.mkdir_p(path)
    end
    new_file = path + "/form_#{@appointment.id}.pdf"
    pdftk.fill_form file_name, new_file, hash
    send_file "#{Rails.root}/#{new_file}"
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new(user_id: User.current.id,
                                   date: Time.now,
                                   with_who_id: User.current_user.id,
                                   related_to_id: params[:case_id])
  end

  # GET /appointments/1/edit
  def edit
    @case=  @appointment.case
    @billings =  @appointment.billings
    # update_rails = @appointment.updated_at.to_date
    @appointment_links = @appointment.appointment_links.includes(:linkable)
    @jsignatures= @appointment.jsignatures
    @cases       = @appointment_links.where(linkable_type: 'Case').map(&:linkable)

    @checklists  = @appointment_links.where(linkable_type: 'ChecklistCase').map(&:linkable)
    @notes       = @appointment_links.where(linkable_type: 'Note').map(&:linkable)
    @appointments= @appointment_links.where(linkable_type: 'Appointment').map(&:linkable)
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    # @appointment.with_who = User.find(params[:appointment][:with_who_id]) rescue nil

    respond_to do |format|
      if @appointment.save
        set_link_to_appointment(@appointment)
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
    # @appointment.with_who = User.find(params[:appointment][:with_who_id]) rescue nil

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
    @appointment = Appointment.includes(:appointment_notes, :user=> :core_demographic).find(params[:id])


    if @appointment.case
      add_breadcrumb @appointment.case, @appointment.case
      add_breadcrumb I18n.t(:appointments), case_path(@appointment.case) + "#tabs-appointments"
    else
      add_breadcrumb I18n.t(:appointments), :appointments_path
    end

    add_breadcrumb @appointment.to_s, appointment_url(@appointment)
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def set_appointment_with_includes
    @appointment = Appointment.includes(:appointment_notes, :appointment_captures, :appointment_dispositions,
                                        :billings, :appointment_procedures ,
                                        :user=> [:core_demographic, :user_extend_demography => [:addresses, :phones]]).
        references(:appointment_notes, :appointment_captures, :appointment_dispositions,
                   :billings, :appointment_procedures ,
                   :user=> [:core_demographic, :user_extend_demography => [:addresses, :phones]]).
        find(params[:id])

    if @appointment.case
      add_breadcrumb @appointment.case, @appointment.case
      add_breadcrumb I18n.t(:appointments), case_path(@appointment.case) + "#tabs-appointments"
    else
      add_breadcrumb I18n.t(:appointments), :appointments_path
    end
    add_breadcrumb @appointment.to_s, appointment_url(@appointment)
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
