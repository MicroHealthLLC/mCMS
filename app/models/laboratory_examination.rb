class LaboratoryExamination < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user

  belongs_to :laboratory_result_status, optional: true

  has_many :laboratory_examination_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :laboratory_examination_attachments, reject_if: :all_blank, allow_destroy: true


  validates_presence_of :user_id, :name

  def self.enumeration_columns
    [["#{LaboratoryResultStatus}", 'laboratory_result_status_id' ]]
  end

  def to_s
    snomed
  end

  def laboratory_result_status
    if laboratory_result_status_id
      super
    else
      LaboratoryResultStatus.default
    end
  end

  def self.safe_attributes
    [
        :user_id, :name, :facility, :date, :result, :laboratory_result_status_id, :snomed,
        laboratory_examination_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Laboratory Examination ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Laboratory Examination "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})

    pdf.table([[ "Name: ", " #{snomed}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Facility: ", " #{facility}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date: ", " #{date}"]], :column_widths => [ 150, 373])

    pdf.table([[ "Laboratory Result Status: ", " #{laboratory_result_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Description: ", " #{ActionView::Base.full_sanitizer.sanitize(result)}"]], :column_widths => [ 150, 373])
  end
  
end
