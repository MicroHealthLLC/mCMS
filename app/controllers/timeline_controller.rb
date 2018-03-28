class TimelineController < ProtectForgeryApplication
  include ApplicationHelper
  before_action  :authenticate_user!
  def index
    # timeline for client patient
    load_client_profile_timeline
    load_occupational_record_timeline
    load_medical_record_timeline
    load_socioeconomic_record_timeline
    load_cases_timeline
  end

  def load_client_profile_timeline
    @client_patient_timeline   = []
    @client_patient_timeline   << Language.visible if module_enabled?( 'languages')  && can?(:manage_roles, :view_languages, :manage_languages)
    @client_patient_timeline   << Contact.visible if module_enabled?( 'contacts')  && can?(:manage_roles, :view_contacts, :manage_contacts)
    @client_patient_timeline   << Affiliation.visible if module_enabled?( 'affiliations')  && can?(:manage_roles, :view_affiliations, :manage_affiliations)
    @client_patient_timeline   << UserInsurance.visible if module_enabled?( 'insurances')  && can?(:manage_roles, :view_insurances, :manage_insurances)
    @client_patient_timeline   << Document.for_profile.visible if module_enabled?( 'documents')  && can?(:manage_roles, :view_documents, :manage_documents)
    # @client_patient_timeline   <<  if module_enabled?( 'jsignatures')  && can?(:manage_roles, :view_jsignatures, :manage_jsignatures)

    @client_patient_timeline.flatten!.compact!
    @client_patient_timeline.sort_by!{|a| Time.now - a.updated_at }

  end

  def load_occupational_record_timeline
    @occupation_record_timeline   = []
    @occupation_record_timeline <<  Education.visible if module_enabled?( 'educations')  && can?(:manage_roles, :view_educations, :manage_educations)
    @occupation_record_timeline << OtherSkill.visible if module_enabled?( 'other_skills')  && can?(:manage_roles, :view_other_skills, :manage_other_skills)
    @occupation_record_timeline << Certification.visible if module_enabled?( 'certifications')  && can?(:manage_roles, :view_certifications, :manage_certifications)
    @occupation_record_timeline << Clearance.visible if module_enabled?( 'clearances')  && can?(:manage_roles, :view_clearances, :manage_clearances)
    @occupation_record_timeline << Position.visible if module_enabled?( 'positions')  && can?(:manage_roles, :view_positions, :manage_positions)

    @occupation_record_timeline << Injury.visible if module_enabled?( 'injuries')  && can?(:manage_roles, :view_injuries, :manage_injuries)
    @occupation_record_timeline << Resume.visible if module_enabled?( 'resumes')  && can?(:manage_roles, :view_resumes, :manage_resumes)
    @occupation_record_timeline << MilitaryHistory.visible  if module_enabled?( 'military_histories')  && can?(:manage_roles, :view_military_histories, :manage_military_histories)
    @occupation_record_timeline << JobApp.where(case_id: nil).visible if module_enabled?( 'job_applications')  && can?(:manage_roles, :view_job_applications, :manage_job_applications)
    @occupation_record_timeline.flatten!.compact!
    @occupation_record_timeline.sort_by!{|a| Time.now - a.updated_at }
  end

  def load_medical_record_timeline
    @medical_record_timeline   = []
    @medical_record_timeline <<  Admission.visible if module_enabled?( 'admissions')  && can?(:manage_roles, :view_admissions, :manage_admissions)
    @medical_record_timeline << HealthCareFacility.visible if module_enabled?( 'health_care_facilities')  && can?(:manage_roles, :view_health_care_facilities, :manage_health_care_facilities)
    @medical_record_timeline << ProblemList.visible if module_enabled?( 'problem_lists')  && can?(:manage_roles, :view_problem_lists, :manage_problem_lists)
    @medical_record_timeline << Surgical.visible if module_enabled?( 'surgicals')  && can?(:manage_roles, :view_surgicals, :manage_surgicals)

    @medical_record_timeline << Medical.visible if module_enabled?( 'medicals')  && can?(:manage_roles, :view_medicals, :manage_medicals)
    @medical_record_timeline << Medication.visible if module_enabled?( 'medications')  && can?(:manage_roles, :view_medications, :manage_medications)
    @medical_record_timeline << BehavioralRisk.visible  if module_enabled?( 'behavioral_risks')  && can?(:manage_roles, :view_behavioral_risks, :manage_behavioral_risks)
    @medical_record_timeline << FamilyHistory.visible  if module_enabled?( 'family_histories')  && can?(:manage_roles, :view_family_histories, :manage_family_histories)
    @medical_record_timeline << Immunization.visible if module_enabled?( 'immunizations')  && can?(:manage_roles, :view_immunizations, :manage_immunizations)
    @medical_record_timeline << Allergy.visible if module_enabled?( 'allergies')  && can?(:manage_roles, :view_allergies, :manage_allergies)
    @medical_record_timeline << LaboratoryExamination.visible if module_enabled?( 'laboratory_examinations')  && can?(:manage_roles, :view_laboratory_examinations, :manage_laboratory_examinations)
    @medical_record_timeline << RadiologicExamination.visible if module_enabled?( 'radiologic_examinations')  && can?(:manage_roles, :view_radiologic_examinations, :manage_radiologic_examinations)
    @medical_record_timeline.flatten!.compact!
    @medical_record_timeline.sort_by!{|a| Time.now - a.updated_at }
  end

  def load_socioeconomic_record_timeline
    @socioeconomic_record_timeline   = []
    @socioeconomic_record_timeline << DailyLiving.visible  if module_enabled?( 'daily_livings')  && can?(:manage_roles, :view_daily_livings, :manage_daily_livings)
    @socioeconomic_record_timeline << Socioeconomic.visible  if module_enabled?( 'socioeconomics')  && can?(:manage_roles, :view_socioeconomics, :manage_socioeconomics)
    @socioeconomic_record_timeline << EnvironmentRisk.visible  if module_enabled?( 'environment_risks')  && can?(:manage_roles, :view_environment_risks, :manage_environment_risks)
    @socioeconomic_record_timeline << Housing.visible  if module_enabled?( 'housings')  && can?(:manage_roles, :view_housings, :manage_housings)
    @socioeconomic_record_timeline << Financial.visible  if module_enabled?( 'financials')  && can?(:manage_roles, :view_financials, :manage_financials)
    @socioeconomic_record_timeline << Legal.visible if module_enabled?( 'legals')  && can?(:manage_roles, :view_legals, :manage_legals)
    @socioeconomic_record_timeline << Transportation.visible  if module_enabled?( 'transportations')  && can?(:manage_roles, :view_transportations, :manage_transportations)
    @socioeconomic_record_timeline << OtherHistory.visible if module_enabled?( 'other_histories')  && can?(:manage_roles, :view_other_histories, :manage_other_histories)
    @socioeconomic_record_timeline.flatten!.compact!
    @socioeconomic_record_timeline.sort_by!{|a| Time.now - a.updated_at }
  end

  def load_cases_timeline

    @timeline = []
    Case.visible.each do |case_record|
      @timeline << case_record.sub_cases
      @timeline << case_record.relations

      @timeline << case_record.tasks
      @timeline << case_record.documents
      @timeline << case_record.case_notes
      @timeline << case_record.appointments
      @timeline << case_record.needs
      @timeline << case_record.plans
      @timeline << case_record.goals
      @timeline << case_record.jsignatures
      @timeline << case_record.enrollments
      @timeline << case_record.referrals
      @timeline << case_record.teleconsults
      @timeline << case_record.transports
      @timeline << case_record.case_supports.active
      @timeline << case_record.worker_compensations
      @timeline << case_record.job_apps
    end

    @timeline.flatten!.compact!
    @timeline.sort_by!{|a| Time.now - a.updated_at }
  end

end
