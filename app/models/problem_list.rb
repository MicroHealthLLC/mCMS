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
    pdf.font_size(25){  pdf.text "Problem List ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Name: </b> #{name}", :inline_format =>  true
    pdf.text "<b>#{I18n.t('icdcm_code')}: </b> #{icdcm_code}", :inline_format =>  true
    pdf.text "<b>Problem List Type: </b> #{problem_type}", :inline_format =>  true
    pdf.text "<b>Problem List Status: </b> #{problem_status}", :inline_format =>  true
    pdf.text "<b>Date resolved: </b> #{date_resolved}", :inline_format =>  true
    pdf.text "<b>Date onset: </b> #{date_onset}", :inline_format =>  true

    pdf.text "<b>description: </b> #{ActionView::Base.full_sanitizer.sanitize(description)}", :inline_format =>  true
  end
  
end
