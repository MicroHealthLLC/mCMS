class Unit < ApplicationRecord
  belongs_to :user
  belongs_to :unit_enum, optional: true
  belongs_to :unit_type, optional: true
  belongs_to :installation_name, optional: true

  has_many :unit_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :unit_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :unit_enum_id, :user_id


  def unit_enum
    if self.unit_enum_id
      super
    else
      UnitEnum.default
    end
  end

 def installation_name
    if self.installation_name_id
      super
    else
      InstallationName.default
    end
  end

  def unit_type
    if self.unit_type_id
      super
    else
      UnitType.default
    end
  end

  def to_s
    unit_enum
  end

  def self.safe_attributes
    [
        :user_id, :unit_enum_id, :unit_type_id,
        :installation_name_id, :date_start, :date_end, :note,
        unit_attachments_attributes: [Attachment.safe_attributes]
    ]
  end
end
