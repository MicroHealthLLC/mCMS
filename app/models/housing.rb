class Housing < ApplicationRecord
  belongs_to :user
  belongs_to :housing_status, :optional=> true
  belongs_to :housing_type, :optional=> true
  belongs_to :cohabitation_type, :optional=> true
  belongs_to :primary_address, :optional=> true, class_name: 'Address'

  has_many :housing_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :housing_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id

  def housing_status
    if housing_status_id
      super
    else
      HousingStatus.default
    end
  end

  def housing_type
    if housing_type_id
      super
    else
      HousingType.default
    end
  end

  def cohabitation_type
    if cohabitation_type_id
      super
    else
      CohabitationType.default
    end
  end

  def to_s
    title
  end

  def self.safe_attributes
    [:user_id, :title, :housing_type_id, :cohabitation_type_id,
     :housing_status_id, :description,
     :primary_address_id, :estimated_monthly_payment,
     :date_start, :date_end,
     housing_attachments_attributes: [Attachment.safe_attributes]]
  end

end
