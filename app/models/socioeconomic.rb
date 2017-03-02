class Socioeconomic < ApplicationRecord
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :socioeconomic_type, optional: true
  belongs_to :socioeconomic_status, optional: true

  has_many :socioeconomic_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :socioeconomic_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :name

  def self.enumeration_columns
    [
        ["#{SocioeconomicType}", 'socioeconomic_type_id'],
        ["#{SocioeconomicStatus}", 'socioeconomic_status_id']
    ]
  end

  def socioeconomic_type
    if socioeconomic_type_id
      super
    else
      SocioeconomicType.default
    end
  end

  def socioeconomic_status
    if socioeconomic_status_id
      super
    else
      SocioeconomicStatus.default
    end
  end


  def to_s
    name
  end

  def self.safe_attributes
    [:name, :user_id, :icdcm_code_id, :date_identified, :date_resolved,
     :socioeconomic_status_id, :socioeconomic_type_id, :description]
  end
end
