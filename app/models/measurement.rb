class Measurement < ApplicationRecord
  validates_presence_of :name, :component, :measured_by

  validate :check_lower_upper

  def check_lower_upper
    if lower_height.to_i > upper_height.to_i
      errors.add(:lower_height, 'must be lower than upper height')
    end
    if lower_weight.to_i > upper_weight.to_i
      errors.add(:lower_weight, 'must be lower than upper weight')
    end

    if lower_measure.to_i > higher_measure.to_i
      errors.add(:lower_measure, 'must be lower than upper measure')
    end
  end

  def self.safe_attributes
    [:name, :component, :order,
     :lower_age, :upper_age,
     :lower_height, :upper_height,
     :lower_weight, :upper_weight,
     :gender, :measured_by,
     :lower_measure, :higher_measure]
  end

  def to_s
    name
  end
end
