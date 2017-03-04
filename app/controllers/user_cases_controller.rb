class UserCasesController < ApplicationController
  add_breadcrumb I18n.t(:home), :root_path
  before_action  :authenticate_user!
  before_action :authorize
  before_action :get_user_cases, only: [:index]
  before_action :set_appointment_links, only: [:show]


  def add_appointment_link
    @link_id = params[:link_id]
    @link_type = params[:link_type]
    @appointment = Appointment.visible.find(params[:appointment_id])
    AppointmentLink.where(user_id: User.current.id,
                          appointment_id: @appointment.id,
                          linkable_id: @link_id,
                          linkable_type: @link_type
    ).first_or_create
    flash[:notice] = "This #{@link_type} is now linked to #{@appointment}"
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
    modules = ['Appointment', 'Referral', 'Need', 'Goal', 'Task',
               'CaseSupport', 'Enrollment', 'Document', 'Teleconsult', 'Plan']
    puts "Related Appointment ID =>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{@link_id}"
    if modules.include?(@link_type)
      c = @link_type.constantize.find(@link_id).case
      @appointments = Appointment.visible.opened.where(related_to_id: c.id) if c
    elsif @link_type == 'Note'
      note = Note.find(@link_id)
      c = note.object.is_a?(Case) ? note.object : note.object.try(:case)
      @appointments = Appointment.visible.opened.where(related_to_id: c.id) if c

    else
      puts "#{@link_type} does not include to =>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{modules}"
    end
  end
end