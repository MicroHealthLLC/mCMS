class Admission < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :admission_status, :optional=> true
  belongs_to :admission_type, optional: true

  has_many :admission_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :admission_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :care_family_name, :user_id

  def admission_status
    if admission_status_id
      super
    else
      AdmissionStatus.default
    end
  end

  def self.enumeration_columns
    [
        ["#{AdmissionType}", 'admission_type_id'],
        ["#{AdmissionStatus}", 'admission_status_id']
    ]
  end

  def admission_type
    if admission_type_id
      super
    else
      AdmissionType.default
    end
  end

  def to_s
    care_family_name
  end

  def self.safe_attributes
    [
        :user_id, :care_family_name, :date_admitted, :date_discharged,
        :admission_status_id, :admission_type_id, :description,
        admission_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){ pdf.table([[ "Admission ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([["Admission"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "name: ", " #{care_family_name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Admission Type: ", " #{admission_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Admission Status: ", " #{admission_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date Admitted: ", " #{date_admitted}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date discharged: ", " #{date_discharged}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end
end
