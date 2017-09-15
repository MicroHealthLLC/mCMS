class UserProfilesController < ProtectForgeryApplication
  include ApplicationHelper
  add_breadcrumb I18n.t(:home), :root_path
  before_action  :authenticate_user!
  before_action :authorize, except: [:occupational_record, :profile_record ]

  def profile_record
    @languages = Language.for_status(params[:status_type]) if module_enabled?( 'languages')  && can?(:manage_roles, :view_languages, :manage_languages)
    @contacts = Contact.for_status(params[:status_type]) if module_enabled?( 'contacts')  && can?(:manage_roles, :view_contacts, :manage_contacts)
    @affiliations = Affiliation.for_status(params[:status_type]) if module_enabled?( 'affiliations')  && can?(:manage_roles, :view_affiliations, :manage_affiliations)
    @user_insurances = UserInsurance.for_status(params[:status_type]) if module_enabled?( 'insurances')  && can?(:manage_roles, :view_insurances, :manage_insurances)
    @documents = Document.for_profile.for_status(params[:status_type]) if module_enabled?( 'documents')  && can?(:manage_roles, :view_documents, :manage_documents)
    @jsignatures = User.current.jsignatures if module_enabled?( 'jsignatures')
  end

  def occupational_record
    @educations = Education.for_status(params[:status_type]) if module_enabled?( 'educations')  && can?(:manage_roles, :view_educations, :manage_educations)
    @other_skills = OtherSkill.for_status(params[:status_type]) if module_enabled?( 'other_skills')  && can?(:manage_roles, :view_other_skills, :manage_other_skills)
    @certifications = Certification.for_status(params[:status_type]) if module_enabled?( 'certifications')  && can?(:manage_roles, :view_certifications, :manage_certifications)
    @clearances = Clearance.for_status(params[:status_type]) if module_enabled?( 'clearances')  && can?(:manage_roles, :view_clearances, :manage_clearances)
    @positions = Position.for_status(params[:status_type]) if module_enabled?( 'positions')  && can?(:manage_roles, :view_positions, :manage_positions)
    @injuries = Injury.for_status(params[:status_type]) if module_enabled?( 'injuries')  && can?(:manage_roles, :view_injuries, :manage_injuries)
    @worker_compensations = WorkerCompensation.for_status(params[:status_type]) if module_enabled?( 'worker_compensations')  && can?(:manage_roles, :view_worker_compensations, :manage_worker_compensations)
    @job_apps = JobApp.for_status(params[:status_type]) if module_enabled?( 'job_applications')  && can?(:manage_roles, :view_job_applications, :manage_job_applications)
    @resumes = Resume.for_status(params[:status_type]) if module_enabled?( 'resumes')  && can?(:manage_roles, :view_resumes, :manage_resumes)
    @military_histories = MilitaryHistory.for_status(params[:status_type]) if module_enabled?( 'military_histories')  && can?(:manage_roles, :view_military_histories, :manage_military_histories)
  end
end