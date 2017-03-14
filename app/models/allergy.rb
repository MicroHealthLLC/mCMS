class Allergy < ApplicationRecord
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'allergy_type_id', class_name: 'Icd10datum'
  belongs_to :allergy_status, optional: true

  has_many :allergy_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :allergy_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id

  def allergy_type
    icdcm_code
  end

  def self.enumeration_columns
    [
        ["#{AllergyStatus}", 'allergy_status_id']
    ]
  end

  def allergy_status
    if allergy_status_id
      super
    else
      AllergyStatus.default
    end
  end


  def to_s
    icdcm_code
  end


  def self.safe_attributes
    [
        :user_id, :allergy_type_id, :medication,
        :allergy_date, :allergy_status_id, :description,
        allergy_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Allergy ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Allergy "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "medication: ", " #{icdcm_code}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Allergy Type: ", " #{allergy_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Allergy Status: ", " #{allergy_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Allergy date: ", " #{allergy_date}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end
end
