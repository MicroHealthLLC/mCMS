class Need < ApplicationRecord
  belongs_to :user
  belongs_to :case, optional: true
  belongs_to :need_enum, optional: true
  belongs_to :priority_type, optional: true
  belongs_to :need_status, optional: true


  def self.safe_attributes
    [ :need_enum_id, :priority_type_id, :user_id, :need_status_id,
      :description, :date_completed, :date_due, :date_identified
    ]
  end

  def need_enum
    if need_enum_id
      super
    else
      NeedEnum.default
    end
  end

  def priority_type
    if priority_type_id
      super
    else
      PriorityType.default
    end
  end

  def need_status
    if need_status_id
      super
    else
      NeedStatus.default
    end
  end
end
