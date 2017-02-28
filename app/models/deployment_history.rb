class DeploymentHistory < ApplicationRecord
  belongs_to :user
  belongs_to :deployment_operation, optional: true
  belongs_to :state_type, optional: true
  belongs_to :country_type, optional: true

  has_many :deployment_history_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :deployment_history_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :deployment_operation_id



  def deployment_operation
    if self.deployment_operation_id
      super
    else
      DeploymentOperation.default
    end
  end

  def state_type
    if state_id
      StateType.find_by(id: state_id)
    else
      StateType.default
    end
  end

  def country_type
    if country_id
      CountryType.find_by(id: country_id)
    else
      CountryType.default
    end
  end

  def to_s
    deployment_operation
  end

  def self.safe_attributes
    [
        :user_id, :deployment_operation_id,
        :location, :city, :state_id,
        :country_id, :date_start,
        :date_end, :note,
        deployment_history_attachments_attributes: [Attachment.safe_attributes]
    ]
  end
end
