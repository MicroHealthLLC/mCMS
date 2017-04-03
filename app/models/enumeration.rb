class Enumeration < ActiveRecord::Base
  include SubclassFactory
  include ActAsPosition
  default_scope lambda {order('position ASC, name ASC')}

  before_destroy :check_integrity
  before_save    :check_default

  before_create :set_default_position
  after_save :update_position
  after_destroy :remove_position

  # attr_protected :type

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:type]
  validates_length_of :name, :maximum => 100

  scope :sorted, lambda { order(:position) }
  scope :active, lambda { where(:active => true) }
  scope :flagged, lambda { where(:is_flagged => true) }
  scope :closed, lambda { where(:is_closed => true) }

  scope :named, lambda {|arg| where("LOWER(#{table_name}.name) = LOWER(?)", arg.to_s.strip)}

  def self.default
    # Creates a fake default scope so Enumeration.default will check
    # it's type.  STI subclasses will automatically add their own
    # types to the finder.
    if self.descends_from_active_record?
      where(:is_default => true, :type => 'Enumeration').first
    else
      # STI classes are
      where(:is_default => true).first
    end
  end

  # Overloaded on concrete classes
  def option_name
    nil
  end

  def check_default
    if is_default? && is_default_changed?
      Enumeration.where({:type => type}).update_all({:is_default => false})
    end
  end

  # Overloaded on concrete classes
  def objects_count
    0
  end

  def in_use?
    self.objects_count != 0
  end

  # Is this enumeration overriding a system level enumeration?
  def is_override?
    !self.parent.nil?
  end

  alias :destroy_without_reassign :destroy

  # Destroy the enumeration
  # If a enumeration is specified, objects are reassigned
  def destroy(reassign_to = nil)
    if reassign_to && reassign_to.is_a?(Enumeration)
      self.transfer_relations(reassign_to)
    end
    destroy_without_reassign
  end

  def <=>(enumeration)
    position <=> enumeration.position
  end

  def to_s; name end

  # Returns the Subclasses of Enumeration.  Each Subclass needs to be
  # required in development mode.
  #
  # Note: subclasses is protected in ActiveRecord
  def self.get_subclasses
    subclasses
  end

  # Does the +new+ Hash override the previous Enumeration?
  def self.overriding_change?(new, previous)
    if same_active_state?(new['active'], previous.active)
      return false
    else
      return true
    end
  end

  # Are the new and previous fields equal?
  def self.same_active_state?(new, previous)
    new = (new == "1" ? true : false)
    return new == previous
  end



  def check_integrity
    raise "Cannot delete enumeration" if self.in_use?
  end

  def set_default_position
    if position.nil?
      self.position = self.class.pluck(:position).compact.count + 1
    end
  end

  def update_position
    super
    # if position_changed?
    #   self.class.update_all(
    #       "position = coalesce((
    #       select count(*) + 1
    #       from enumerations where id< id  AND type = '#{e}'), 1)"
    #   )
    # end
  end
end
# require_dependency 'enumerations/*.rb'
require_dependency 'accept_assignment'
require_dependency 'address_type'
require_dependency 'admission_status'
require_dependency 'admission_type'
require_dependency 'affiliation_status'
require_dependency 'affiliation_type'
require_dependency 'allergy_status'
require_dependency 'application_status'
require_dependency 'application_type'
require_dependency 'appointment_status'
require_dependency 'appointment_type'
require_dependency 'assessment'
require_dependency 'behavioral_risk_status'
require_dependency 'behavioral_risk_type'
require_dependency 'bill_status'
require_dependency 'bill_type'
require_dependency 'case_category_type'
require_dependency 'case_source'
require_dependency 'case_status_type'
require_dependency 'case_support_type'
require_dependency 'case_type'
require_dependency 'certification_status'
require_dependency 'certification_type'
require_dependency 'checklist_status_type'
require_dependency 'checklist_type'
require_dependency 'citizenship_type'
require_dependency 'clearence_status'
require_dependency 'clearence_type'
require_dependency 'client_journal_type'
require_dependency 'cohabitation_type'
require_dependency 'compensation_status'
require_dependency 'compensation_type'
require_dependency 'consult_status'
require_dependency 'contact_method'
require_dependency 'contact_status'
require_dependency 'contact_type'
require_dependency 'country_type'
require_dependency 'daily_living_status'
require_dependency 'daily_living_type'
require_dependency 'department_type'
require_dependency 'disposition'
require_dependency 'disposition_related_to'
require_dependency 'document_type'
require_dependency 'education_status'
require_dependency 'education_type'
require_dependency 'em_code'
require_dependency 'email_type'
require_dependency 'emergency'
require_dependency 'employment_type'
require_dependency 'enrollment_status'
require_dependency 'enrollment_type'
require_dependency 'environment_status'
require_dependency 'environment_type'
require_dependency 'epsdt'
require_dependency 'ethnicity_type'
require_dependency 'family_status'
require_dependency 'family_type'
require_dependency 'fax_type'
require_dependency 'financial_state'
require_dependency 'financial_status'
require_dependency 'financial_type'
require_dependency 'gender_type'
require_dependency 'goal_status'
require_dependency 'health_care_facility_status'
require_dependency 'health_care_facility_type'
require_dependency 'housing_status'
require_dependency 'housing_type'
require_dependency 'identification_type'
require_dependency 'immunization_status'
require_dependency 'injury_status'
require_dependency 'injury_type'
require_dependency 'insurance_relationship'
require_dependency 'insurance_status'
require_dependency 'insurance_type'
require_dependency 'interview_status'
require_dependency 'interview_type'
require_dependency 'issued_by_type'
require_dependency 'laboratory_result_status'
require_dependency 'language_status'
require_dependency 'language_type'
require_dependency 'legal_history_status'
require_dependency 'legal_history_type'
require_dependency 'location_type'
require_dependency 'marital_status'
require_dependency 'medical_history_status'
require_dependency 'medical_history_type'
require_dependency 'medication_status'
require_dependency 'need_enum'
require_dependency 'need_status'
require_dependency 'organization_type'
require_dependency 'other_history_status'
require_dependency 'other_history_type'
require_dependency 'other_skill_status'
require_dependency 'other_skill_type'
require_dependency 'outside_lab'
require_dependency 'pay_rate_type'
require_dependency 'phone_type'
require_dependency 'plan_status'
require_dependency 'position_status'
require_dependency 'priority_type'
require_dependency 'problem_status'
require_dependency 'problem_type'
require_dependency 'procedure'
require_dependency 'proficiency_type'
require_dependency 'radiologic_result_status'
require_dependency 'referral_status'
require_dependency 'referral_type'
require_dependency 'religion_type'
require_dependency 'resume_status'
require_dependency 'resume_type'
require_dependency 'role_type'
require_dependency 'selection_status'
require_dependency 'service_status'
require_dependency 'service_type'
require_dependency 'social_media_type'
require_dependency 'socioeconomic_status'
require_dependency 'socioeconomic_type'
require_dependency 'state_type'
require_dependency 'support_status'
require_dependency 'surgery_status'
require_dependency 'surgery_type'
require_dependency 'survey_type'
require_dependency 'task_status_type'
require_dependency 'task_type'
require_dependency 'transportation_accessibility'
require_dependency 'transportation_mean'
require_dependency 'transportation_status'
require_dependency 'transportation_type'
