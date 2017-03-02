class WorkerCompensation < ApplicationRecord
  belongs_to :user
  belongs_to :injury

  belongs_to :compensation_type, optional: true
  belongs_to :compensation_status, optional: true

  has_many :worker_compensation_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :worker_compensation_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :injury_id

  def self.enumeration_columns
    [
        ["#{CompensationType}", 'compensation_type_id'],
        ["#{CompensationStatus}", 'compensation_status_id']
    ]
  end

  def compensation_type
    if compensation_type_id
      super
    else
      CompensationType.default
    end
  end

  def compensation_status
    if compensation_status_id
      super
    else
      CompensationStatus.default
    end
  end


  def to_s
    injury.to_s
  end

  def self.safe_attributes
    [
        :user_id, :injury_id, :compensation_type_id, :compensation_status_id,
        :description, :date_of_compensation_start, :date_of_compensation_end,
        worker_compensation_attachments_attributes: [Attachment.safe_attributes]
    ]
  end
end
