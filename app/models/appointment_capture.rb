class AppointmentCapture < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :assessment, optional: true
  belongs_to :user
  belongs_to :appointment
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'

  validates_presence_of :user_id, :appointment_id, :note

  def self.safe_attributes
    [
        :user_id, :appointment_id, :assessment_id, :note, :date_recorded, :icdcm_code_id
    ]
  end

  def assessment
    if assessment_id
      super
    else
      Assessment.default
    end
  end

  def to_s
    assessment
  end

  def to_pdf(pdf, show_user= true)
    pdf.font_size(25){  pdf.table([[ "Assessment ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    pdf.table([[ "Assessment: ", " #{assessment}"]], :column_widths => [ 150, 373])
    pdf.table([[ "#{I18n.t('icdcm_code')}: ", " #{icdcm_code}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date Recorded: ", " #{date_recorded}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])

  end

end
