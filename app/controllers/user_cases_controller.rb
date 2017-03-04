class UserCasesController < ApplicationController
  add_breadcrumb I18n.t(:home), :root_path
  before_action  :authenticate_user!
  before_action :authorize
  before_action :get_user_cases, only: [:index]
  before_action :set_appointment_links, only: [:show]


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

  def add_appointment_link
    @link_id = params[:link_id]
    @link_type = params[:link_type]
    @appointment = Appointment.visible.find(params[:appointment_id])
    a = AppointmentLink.where( appointment_id: @appointment.id,
                               linkable_id: @link_id,
                               linkable_type: @link_type
    ).first_or_initialize
    a.user_id = User.current.id
    a.save
    flash[:notice] = "This #{@link_type} is now linked to <a href='/appointments/#{@appointment.id}'>#{@appointment}".html_safe
    session[:appointment_store_id] = @appointment.id
    redirect_back(fallback_location: root_url)
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  private
  def get_user_cases
    @cases_for_btn = Case.visible
  end

  def set_appointment_links
    @link_id = params[:id]
    @link_type = params[:controller].classify
    puts "Related Appointment =>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{@link_type}"
    modules = ['Referral', 'Need', 'Goal', 'Task',
               'CaseSupport', 'ChecklistCase', 'Enrollment', 'Document', 'Teleconsult', 'Plan']
    puts "Related Appointment ID =>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{@link_id}"
    if modules.include?(@link_type)
      c = @link_type.constantize.find(@link_id).case
      @appointments_case = Appointment.visible.opened.where(related_to_id: c.id) if c
    elsif @link_type == 'Case'
      c = Case.find(@link_id)
      cc= [c.id, c.case.try(:id)].compact
      @appointments_case = Appointment.visible.opened.where(related_to_id: cc)
    elsif @link_type == 'Appointment'
      app = Appointment.find(@link_id)
      c = app.case
      @appointments_case = Appointment.visible.opened.where(related_to_id: c.id) - [app] if c
      puts @appointments
    elsif @link_type == 'Note'
      note = Note.find(@link_id)
      c = note.object.is_a?(Case) ? note.object : note.object.try(:case)
      @appointments_case = Appointment.visible.opened.where(related_to_id: c.id) if c
    else
      puts "#{@link_type} does not include to =>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{modules}"
    end
  end
end