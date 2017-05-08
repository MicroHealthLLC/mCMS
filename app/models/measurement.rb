class Measurement < ApplicationRecord
  validates_presence_of :measurement_name_id, :component, :measured_by_id

  validate :check_lower_upper

  belongs_to :gender_type, :foreign_key => 'gender_id'
  belongs_to :measured_by
  belongs_to :measurement_name

  def gender
    gender_type || GenderType.default
  end

  def measurement_name
    if self.measurement_name_id
      super
    else
      MeasurementName.default
    end
  end

  def measured_by
    super || MeasuredBy.default
  end

  def possible_components
    Measurement.where(measurement_name_id: self.measurement_name_id)
  end

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

  def self.from_age(age)
    scope = where(nil)
    if age.to_i > 0
      scope = scope.where("(upper_age = :age_zero AND lower_age = :age_zero) OR upper_age >= :age AND lower_age <= :age", age: age.to_i, age_zero: 0)
    end
    scope
  end

 def self.from_height(height)
    scope = where(nil)
    if height.to_i > 0
      scope = scope.where("(upper_height = :height_zero AND lower_height = :height_zero) OR upper_height >= :height AND lower_height <= :height", height: height.to_i, height_zero: 0)
    end
    scope
  end

 def self.from_weight(weight)
    scope = where(nil)
    if weight.to_i > 0
      scope = scope.where("(upper_weight = :weight_zero AND lower_weight = :weight_zero) OR upper_weight >= :weight AND lower_weight <= :weight", weight: weight.to_i, weight_zero: 0)
    end
    scope
  end

 def self.from_gender(gender)
    scope = where(nil)
    if gender.to_i > 0
      scope = scope.where(" gender_id = :gender", gender: gender.to_i)
    end
    scope
  end

  def self.safe_attributes
    [:name, :component, :order,
     :lower_age, :upper_age,
     :lower_height, :upper_height,
     :measurement_name_id,
     :lower_weight, :upper_weight,
     :gender_id, :measured_by_id,
     :lower_measure, :higher_measure]
  end

  def to_s
    measurement_name
  end
end
