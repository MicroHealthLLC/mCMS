class ServiceHistory < ApplicationRecord
  belongs_to :user
  belongs_to :service_status, optional: true
  belongs_to :service_type, optional: true
  belongs_to :rank, optional: true
  belongs_to :discharge_type, optional: true
  belongs_to :component, optional: true

  has_many :service_history_attachments, foreign_key: :owner_id
  accepts_nested_attributes_for :service_history_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :service_type_id, :user_id


  def service_status
    super || ServiceStatus.default
  end

  def service_type
    super || ServiceType.default
  end

 def rank
    super || Rank.default
  end

 def discharge_type
    super || DischargeType.default
  end

 def component
    super || Component.default
  end

  def to_s
    service_type
  end

  def self.safe_attributes
    [
        :user_id, :rank_id, :service_type_id,
        :service_status_id, :component_id, :discharge_type_id,
        :date_entered, :end_active_obliged_service,
        :demobilization, :separation,
        :temporary_disability_retirement_list,
        :permanent_disability_retirement_list,
        :note,
        service_history_attachments_attributes: [Attachment.safe_attributes]
    ]
  end
end
