class UserCasesController < ProtectForgeryApplication
  add_breadcrumb 'Case Records', :cases_path
  before_action  :authenticate_user!
  before_action :authorize
  before_action :get_user_cases, only: [:index]
  before_action :set_appointment_links, only: [:index, :show, :edit, :new]

  after_action :link_module_to_appointment, only: [:update]


  # To unlink module with appointment
  def unlink_appointment
    @link_id = params[:id]
    @link_type = params[:type]
    @appointment = Appointment.visible.find(params[:appointment_id])
    AppointmentLink.where(appointment_id: @appointment.id,
                          linkable_id: @link_id,
                          linkable_type: @link_type
    ).delete_all
    flash[:notice] = "This #{@link_type} is now Unlinked to <a href='/appointments/#{@appointment.id}'>#{@appointment}".html_safe

    redirect_back(fallback_location: root_url)
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Set appointment to link it with case's module
  def set_appointment_store_id
    begin
      @appointment = Appointment.visible.find(params[:appointment_store_id])
      flash[:notice] = "All Module's changes will be linked to <a href='/appointments/#{@appointment.id}'>#{@appointment}".html_safe
      session[:appointment_store_id] = @appointment.id
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Linking modules disabled".html_safe
      session[:appointment_store_id] = nil
    end
    puts "#{session[:appointment_store_id]}"
    redirect_back(fallback_location: root_url)
  end

  private
  def get_user_cases
    @cases_for_btn = Case.visible
  end

  # Before Show action get all appointment that are opened
  def set_appointment_links
    set_variable
    if session[:appointment_store_id] and @stored_appointment.nil?
      session[:appointment_store_id] = nil
    end
  end

  def set_variable
    @link_id = params[:id]
    @link_type = params[:controller].classify
    @appointments_case = Appointment.visible.opened
    @modules = [
        'Referral', 'Need', 'Goal', 'Case',
        'Task', 'CaseSupport', 'ChecklistCase', 'WorkerCompensation', 'JobApp',
        'Note', 'Appointment', 'Enrollment', 'Jsignature',
        'Document', 'Teleconsult', 'Plan'
    ]
    if session[:appointment_store_id] and @appointments_case.pluck(:id).include?(session[:appointment_store_id].to_i)
      @stored_appointment = Appointment.find(session[:appointment_store_id])
    end

  end

  def link_module_to_appointment
    set_variable
    if @modules.include?(@link_type) and @stored_appointment
      AppointmentLink.create_or_update(@stored_appointment, @link_type, @link_id)
    end
  end

  def set_link_to_appointment(object)
    @stored_appointment = Appointment.visible.opened.find_by_id(session[:appointment_store_id])
    AppointmentLink.create_or_update(@stored_appointment, object.class.to_s, object.id) if @stored_appointment
  end


  def set_client_profile(object)
    if User.current_user.allowed_to?(:manage_roles) and object.user
      session[:employee_id] = object.user.id
      User.current = object.user
    end
  end

  def back_index_case_url
    if @case
      case_path(@case) + "#tabs-#{params[:controller]}"
    else
      {controller: params[:controller], action: 'index'}
    end
  end
end
