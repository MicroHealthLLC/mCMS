class Formular < ApplicationRecord
  include OrganizationConcern
  validates_presence_of :name, :form
  validates_uniqueness_of :name

  belongs_to :form_type
  belongs_to :user

  belongs_to :organization
  has_many :form_details, dependent: :destroy
  # has_many :form_results, through: :form_details, dependent: :destroy

  PROFILE_RECORD = 1
  OCCUPATION_RECORD = 2
  HEALTH_RECORD = 3
  SOCIOECONOMIC_RECORD = 4
  CASE_RECORD = 5

  EMPLACEMENT = [
      ['Profile Record', PROFILE_RECORD],
      ['Occupation Record', OCCUPATION_RECORD],
      ['Health Record', HEALTH_RECORD],
      ['Socioeconomic Record', SOCIOECONOMIC_RECORD],
      ['Case Record', CASE_RECORD]]

  def self.for(emplacement)
    where(placement: emplacement)
  end


  def self.enumeration_columns
    [
        ["#{FormType}", 'form_type_id']
    ]
  end

  def self.include_enumerations
    includes(:form_type).references(:form_type)
  end


  def form_type
    if form_type_id
      super
    else
      FormType.default
    end
  end

  def self.safe_attributes
    [:name, :icon, :placement, :form_type_id, :description, :form, :organization_id, :user_id]
  end

  def emplacement
    case placement
      when PROFILE_RECORD then 'Profile Record'
      when OCCUPATION_RECORD then 'Occupation Record'
      when HEALTH_RECORD then 'Health Record'
      when SOCIOECONOMIC_RECORD then 'Socioeconomic Record'
      when CASE_RECORD then 'Case Record'
      else ''

    end
  end
end
