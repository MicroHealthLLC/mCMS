class MeasurementRecord < ApplicationRecord
  belongs_to :user
  belongs_to :component, class_name: 'Measurement'
  belongs_to :case, optional: true
  belongs_to :plan, optional: true
  belongs_to :recorded_by, optional: true, class_name: 'User'
  belongs_to :measurement_status, optional: true
  validates_presence_of :user_id, :measurement,
                        :component, :date_time, :recorded_by_id


  def can_hide?(type)
    case type
      when 'age' then component and component.lower_age.to_i > 0 ? false : true
      when 'height' then component and component.lower_height.to_i > 0 ? false : true
      when 'weight' then component and component.lower_weight.to_i > 0 ? false : true
      when 'measure' then component and component.lower_measure.to_i > 0 ? false : true
      else
        true
    end
  end

  def measurement_status
    super || MedicationStatus.default
  end

  def to_s
    id
  end

  def self.safe_attributes
    [:measurement, :component_id, :measured_by, :date_time,
     :recorded_by_id, :user_id, :device_id, :age, :height,
     :weight, :gender, :measure, :flag, :measurement_status_id, :case_id, :plan_id]
  end
end
