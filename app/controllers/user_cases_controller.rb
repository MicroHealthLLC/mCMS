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
    if @link_type.in?(['Appointment', 'Referral', 'Jsignature' 'Need', 'Goal', 'Task', 'CaseSupport' 'Enrollment', 'Document', 'Teleconsult', 'Plan'])
      c = @link_type.constantize.find(@link_id).case
      @appointments = Appointment.where(related_to_id: c.id).visible
    end
  rescue Exception => e
    @link_type = nil
  end
end