class Admission < ApplicationRecord
  belongs_to :user
  belongs_to :admission_status, :optional=> true
  belongs_to :admission_type, optional: true

  has_many :admission_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :admission_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :care_family_name, :user_id

  def admission_status
    if admission_status_id
      super
    else
      AdmissionStatus.default
    end
  end

  def self.enumeration_columns
    [
        ["#{AdmissionType}", 'admission_type_id'],
        ["#{AdmissionStatus}", 'admission_status_id']
    ]
  end

  def admission_type
    if admission_type_id
      super
    else
      AdmissionType.default
    end
  end

  def to_s
    care_family_name
  end

  def self.safe_attributes
    [
        :user_id, :care_family_name, :date_admitted, :date_discharged,
        :admission_status_id, :admission_type_id, :description,
        admission_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

end
