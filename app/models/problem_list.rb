class ProblemList < ApplicationRecord
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :problem_type, optional: true
  belongs_to :problem_status, optional: true

  has_many :problem_list_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :problem_list_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :name

  def self.enumeration_columns
    [
        ["#{ProblemType}", 'problem_type_id'],
        ["#{ProblemStatus}", 'problem_status_id']
    ]
  end

  def problem_type
    if problem_type_id
      super
    else
      ProblemType.default
    end
  end

  def problem_status
    if problem_status_id
      super
    else
      ProblemStatus.default
    end
  end


  def to_s
    name
  end

  def self.safe_attributes
    [:name, :icdcm_code_id, :user_id, :date_onset, :date_resolved, :problem_status_id, :problem_type_id, :description,
     problem_list_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.table([[ "Problem List ##{id}" ]], :column_widths => [ 523], :cell_style=> {:style => :bold, align: :center})}
    user.to_pdf_brief_info(pdf) ; pdf.table([["Informations Data "]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Name: ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "#{I18n.t('icdcm_code')}: ", " #{icdcm_code}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Problem List Type: ", " #{problem_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Problem List Status: ", " #{problem_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date resolved: ", " #{date_resolved}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date onset: ", " #{date_onset}"]], :column_widths => [ 150, 373])

    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end
  
end
