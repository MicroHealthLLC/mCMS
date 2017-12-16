class UserHistoryController < ProtectForgeryApplication
  include ApplicationHelper
  before_action  :authenticate_user!
  before_action :authorize, except: [:medical_record, :socioeconomic_record]

  def medical_record
    add_breadcrumb 'Health History', '/medical_record'
    @admissions = [] if module_enabled?( 'admissions')  && can?(:manage_roles, :view_admissions, :manage_admissions)
    @health_care_facilities =  [] if module_enabled?( 'health_care_facilities')  && can?(:manage_roles, :view_health_care_facilities, :manage_health_care_facilities)
    @problem_lists = [] if module_enabled?( 'problem_lists')  && can?(:manage_roles, :view_problem_lists, :manage_problem_lists)
    @surgicals = [] if module_enabled?( 'surgicals')  && can?(:manage_roles, :view_surgicals, :manage_surgicals)

    @medicals = [] if module_enabled?( 'medicals')  && can?(:manage_roles, :view_medicals, :manage_medicals)
    @medications = [] if module_enabled?( 'medications')  && can?(:manage_roles, :view_medications, :manage_medications)
    @behavioral_risks = [] if module_enabled?( 'behavioral_risks')  && can?(:manage_roles, :view_behavioral_risks, :manage_behavioral_risks)
    @family_histories = [] if module_enabled?( 'family_histories')  && can?(:manage_roles, :view_family_histories, :manage_family_histories)
    @immunizations = [] if module_enabled?( 'immunizations')  && can?(:manage_roles, :view_immunizations, :manage_immunizations)
    @allergies = [] if module_enabled?( 'allergies')  && can?(:manage_roles, :view_allergies, :manage_allergies)
    @laboratory_examinations =  [] if module_enabled?( 'laboratory_examinations')  && can?(:manage_roles, :view_laboratory_examinations, :manage_laboratory_examinations)
    @radiologic_examinations = [] if module_enabled?( 'radiologic_examinations')  && can?(:manage_roles, :view_radiologic_examinations, :manage_radiologic_examinations)
  end

  def socioeconomic_record
    add_breadcrumb 'Socioeconomic History', '/socioeconomic_record'
    @daily_livings =  []  if module_enabled?( 'daily_livings')  && can?(:manage_roles, :view_daily_livings, :manage_daily_livings)
    @socioeconomics = []  if module_enabled?( 'socioeconomics')  && can?(:manage_roles, :view_socioeconomics, :manage_socioeconomics)
    @environment_risks = []  if module_enabled?( 'environment_risks')  && can?(:manage_roles, :view_environment_risks, :manage_environment_risks)
    @housings = []  if module_enabled?( 'housings')  && can?(:manage_roles, :view_housings, :manage_housings)
    @financials = []  if module_enabled?( 'financials')  && can?(:manage_roles, :view_financials, :manage_financials)
    @legals = [] if module_enabled?( 'legals')  && can?(:manage_roles, :view_legals, :manage_legals)
    @transportations = []  if module_enabled?( 'transportations')  && can?(:manage_roles, :view_transportations, :manage_transportations)
    @other_histories = [] if module_enabled?( 'other_histories')  && can?(:manage_roles, :view_other_histories, :manage_other_histories)
  end
end