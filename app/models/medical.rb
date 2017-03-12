class Medical < ApplicationRecord
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :medical_history_type, optional: true
  belongs_to :medical_history_status, optional: true

  has_many :medical_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :medical_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :name

  def self.enumeration_columns
    [
        ["#{MedicalHistoryType}", 'medical_history_type_id'],
        ["#{MedicalHistoryStatus}", 'medical_history_status_id']
    ]
  end

  def medical_history_type
    if medical_history_type_id
      super
    else
      MedicalHistoryType.default
    end
  end

  def medical_history_status
    if medical_history_status_id
      super
    else
      MedicalHistoryStatus.default
    end
  end

  def to_s
    name
  end

  def self.safe_attributes
    [:name, :user_id, :icdcm_code_id, :medical_facility, :date_of_diagnosis,
     :medical_history_status_id, :medical_history_type_id, :description,
     medical_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.table([[ "Medical History ##{id}"]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf)
    pdf.table([[ "Name: ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Icdcm code: ", " #{icdcm_code}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Medical facility: ", " #{medical_facility}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Medical History Type: ", " #{medical_history_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Medical History Status: ", " #{medical_history_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date of diagnosis: ", " #{date_of_diagnosis}"]], :column_widths => [ 150, 373])

    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end

end
