class DeploymentHistory < ApplicationRecord
  belongs_to :user
  belongs_to :deployment_operation, optional: true
  belongs_to :state, optional: true, class_name: 'StateType'
  belongs_to :country_type, optional: true

  has_many :deployment_history_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :deployment_history_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :deployment_operation_id


  def self.enumeration_columns
    [
        ["#{DeploymentOperation}", 'deployment_operation_id'],
        ["#{CountryType}", 'country_id'],
        ["#{StateType}", 'state_id']
    ]
  end

  def deployment_operation
    if self.deployment_operation_id
      super
    else
      DeploymentOperation.default
    end
  end

  def state
    if state_id
      super
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
