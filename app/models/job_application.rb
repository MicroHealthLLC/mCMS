class JobApplication < ApplicationRecord
  belongs_to :user

  belongs_to :application_type, optional: true
  belongs_to :application_status, optional: true
  belongs_to :interview_type, optional: true
  belongs_to :interview_status, optional: true
  belongs_to :selection_status, optional: true

  has_many :job_application_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :job_application_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :employer

  def self.enumeration_columns
    [
        ["#{ApplicationType}", 'application_type_id'],
        ["#{ApplicationStatus}", 'application_status_id'],
        ["#{InterviewStatus}", 'interview_status_id'],
        ["#{InterviewType}", 'interview_type_id']
    ]
  end

  def application_type
    if application_type_id
      super
    else
      ApplicationType.default
    end
  end

  def application_status
    if application_status_id
      super
    else
      ApplicationStatus.default
    end
  end

  def interview_type
    if interview_type_id
      super
    else
      InterviewType.default
    end
  end

  def interview_status
    if interview_status_id
      super
    else
      InterviewStatus.default
    end
  end

  def selection_status
    if selection_status_id
      super
    else
      SelectionStatus.default
    end
  end


  def to_s
    employer
  end

  def self.safe_attributes
    [
        :user_id, :employer, :position_applied, :projected_salary,
        :application_type_id, :application_date, :application_status_id, :interview_type_id,
        :interview_date, :interview_status_id, :selection_status_id,
        job_application_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

end
