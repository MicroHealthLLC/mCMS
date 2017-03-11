class UserHistoryController < ApplicationController
  include ApplicationHelper
  add_breadcrumb I18n.t(:home), :root_path
  before_action  :authenticate_user!
  before_action :authorize, except: [:medical_record, :socioeconomic_record]

  def medical_record
    @admissions = Admission.visible.all_data if module_enabled?( 'admissions')  && can?(:manage_roles, :view_admissions, :manage_admissions)
    @health_care_facilities = HealthCareFacility.visible.all_data if module_enabled?( 'health_care_facilities')  && can?(:manage_roles, :view_health_care_facilities, :manage_health_care_facilities)
    @problem_lists = ProblemList.visible.all_data if module_enabled?( 'problem_lists')  && can?(:manage_roles, :view_problem_lists, :manage_problem_lists)
    @surgicals = Surgical.visible.all_data if module_enabled?( 'surgicals')  && can?(:manage_roles, :view_surgicals, :manage_surgicals)
    @medicals = Medical.visible.all_data if module_enabled?( 'medicals')  && can?(:manage_roles, :view_medicals, :manage_medicals)
    @medications = Medication.visible.all_data if module_enabled?( 'medications')  && can?(:manage_roles, :view_medications, :manage_medications)
    @behavioral_risks = BehavioralRisk.visible.all_data if module_enabled?( 'behavioral_risks')  && can?(:manage_roles, :view_behavioral_risks, :manage_behavioral_risks)
    @family_histories = FamilyHistory.visible.all_data if module_enabled?( 'family_histories')  && can?(:manage_roles, :view_family_histories, :manage_family_histories)
    @immunizations = Immunization.visible.all_data if module_enabled?( 'immunizations')  && can?(:manage_roles, :view_immunizations, :manage_immunizations)
    @allergies = Allergy.visible.all_data if module_enabled?( 'allergies')  && can?(:manage_roles, :view_allergies, :manage_allergies)
  end

  def socioeconomic_record
    @daily_livings = DailyLiving.visible.all_data  if module_enabled?( 'daily_livings')  && can?(:manage_roles, :view_daily_livings, :manage_daily_livings)
    @socioeconomics = Socioeconomic.visible.all_data  if module_enabled?( 'socioeconomics')  && can?(:manage_roles, :view_socioeconomics, :manage_socioeconomics)
    @environment_risks = EnvironmentRisk.visible.all_data  if module_enabled?( 'environment_risks')  && can?(:manage_roles, :view_environment_risks, :manage_environment_risks)
    @housings = Housing.visible.all_data  if module_enabled?( 'housings')  && can?(:manage_roles, :view_housings, :manage_housings)
    @financials = Financial.visible.all_data  if module_enabled?( 'financials')  && can?(:manage_roles, :view_financials, :manage_financials)
    @legals = Legal.visible.all_data  if module_enabled?( 'legals')  && can?(:manage_roles, :view_legals, :manage_legals)
    @transportations = Transportation.visible.all_data  if module_enabled?( 'transportations')  && can?(:manage_roles, :view_transportations, :manage_transportations)
    @other_histories = OtherHistory.visible.all_data  if module_enabled?( 'other_histories')  && can?(:manage_roles, :view_other_histories, :manage_other_histories)
  end
end