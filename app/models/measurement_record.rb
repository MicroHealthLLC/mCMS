class MeasurementRecord < ApplicationRecord
  belongs_to :user
  belongs_to :component, class_name: 'Measurement'
  belongs_to :case, optional: true
  belongs_to :plan, optional: true
  belongs_to :gender_type, optional: true, foreign_key: :gender_id
  belongs_to :recorded_by, optional: true, class_name: 'User'
  belongs_to :measurement_status, optional: true
  
  has_many :appointment_links, as: :linkable
  
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

  def self.enumeration_columns
    [
        ["#{MeasurementStatus}", 'measurement_status_id']
    ]
  end
  
  def self.include_enumerations
    includes(:case, :recorded_by,:measurement_status  , :component).
        references(:case, :recorded_by,:measurement_status  , :component)
  end

  def self.csv_attributes
    [
    'Measurement',
    'Component',
    'Measure',
    'Measured by',
    'Date time',
    'Recorded by',
    'Flag',
    'Measurement status'
    ]
  end
  
  def gender
    gender_type || GenderType.default
  end

  def measurement_status
    super || MedicationStatus.default
  end

  def measurement_parents
    @measurements ||= begin
      scope = MeasurementName.find_by(name: self.measurement).measurements
      scope = scope.from_age(self.age)
      scope = scope.from_height(self.height)
      scope = scope.from_weight(self.weight)
      scope
    end
  end

  def to_s
    measurement
  end

  def self.safe_attributes
    [:measurement, :component_id, :measured_by, :date_time,
     :recorded_by_id, :user_id, :device_id, :age, :height, :gender_id,
     :weight, :gender, :measure, :flag, :measurement_status_id, :case_id, :plan_id]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Measurement ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([["Measurment "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Name: ", " #{measurement}"]], :column_widths => [ 150, 373])
    pdf.table([[ "component: ", " #{component.component}"]], :column_widths => [ 150, 373])
    pdf.table([[ "measured by: ", " #{measured_by}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date & time: ", " #{date_time}"]], :column_widths => [ 150, 373])
    pdf.table([[ "recorded by: ", " #{recorded_by}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Age: ", " #{age}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Height: ", " #{height}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Weight: ", " #{weight}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Measure: ", " #{measure}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Flag: ", " #{flag}"]], :column_widths => [ 150, 373])

  end

end
