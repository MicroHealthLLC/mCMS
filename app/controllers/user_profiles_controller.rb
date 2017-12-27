class UserProfilesController < ProtectForgeryApplication
  include ApplicationHelper
  before_action  :authenticate_user!
  before_action :authorize, except: [:occupational_record, :profile_record ]

  def profile_record
    @is_client_doc = true
    add_breadcrumb 'Client Profile', '/profile_record'
    @languages             = [] if module_enabled?( 'languages')  && can?(:manage_roles, :view_languages, :manage_languages)
    @contacts              = [] if module_enabled?( 'contacts')  && can?(:manage_roles, :view_contacts, :manage_contacts)
    @affiliations          = [] if module_enabled?( 'affiliations')  && can?(:manage_roles, :view_affiliations, :manage_affiliations)
    @user_insurances       = [] if module_enabled?( 'insurances')  && can?(:manage_roles, :view_insurances, :manage_insurances)
    @documents             = [] if module_enabled?( 'documents')  && can?(:manage_roles, :view_documents, :manage_documents)
    @jsignatures           = [] if module_enabled?( 'jsignatures')
  end

  def occupational_record
    add_breadcrumb 'Occupational History', '/occupational_record'

    @educations            = [] if module_enabled?( 'educations')  && can?(:manage_roles, :view_educations, :manage_educations)
    @other_skills          = [] if module_enabled?( 'other_skills')  && can?(:manage_roles, :view_other_skills, :manage_other_skills)
    @certifications        = [] if module_enabled?( 'certifications')  && can?(:manage_roles, :view_certifications, :manage_certifications)
    @clearances            = [] if module_enabled?( 'clearances')  && can?(:manage_roles, :view_clearances, :manage_clearances)
    @positions             = [] if module_enabled?( 'positions')  && can?(:manage_roles, :view_positions, :manage_positions)

    @injuries              = [] if module_enabled?( 'injuries')  && can?(:manage_roles, :view_injuries, :manage_injuries)
    @worker_compensations  = [] if module_enabled?( 'worker_compensations')  && can?(:manage_roles, :view_worker_compensations, :manage_worker_compensations)
    @job_apps              = [] if module_enabled?( 'job_applications')  && can?(:manage_roles, :view_job_applications, :manage_job_applications)
    @resumes               = [] if module_enabled?( 'resumes')  && can?(:manage_roles, :view_resumes, :manage_resumes)
    @military_histories    = [] if module_enabled?( 'military_histories')  && can?(:manage_roles, :view_military_histories, :manage_military_histories)
  end
end
