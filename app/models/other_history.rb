class OtherHistory < ApplicationRecord
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :other_history_type, optional: true
  belongs_to :other_history_status, optional: true

  has_many :other_history_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :other_history_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :name

  def self.enumeration_columns
    [
        ["#{OtherHistoryType}", 'other_history_type_id'],
        ["#{OtherHistoryStatus}", 'other_history_status_id']
    ]
  end

  def other_history_type
    if other_history_type_id
      super
    else
      OtherHistoryType.default
    end
  end

  def other_history_status
    if other_history_status_id
      super
    else
      OtherHistoryStatus.default
    end
  end

  def to_s
    name
  end
  
  def self.safe_attributes
    [:name, :user_id, :icdcm_code_id, :date_identified, :date_resolved,
     :other_history_status_id, :other_history_type_id, :description,
     other_history_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Other History ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Name: </b> #{name}", :inline_format =>  true
    pdf.text "<b>Icdcm Code: </b> #{icdcm_code}", :inline_format =>  true
    pdf.text "<b>Other History Type: </b> #{other_history_type}", :inline_format =>  true
    pdf.text "<b>Other History Status: </b> #{other_history_status}", :inline_format =>  true
    pdf.text "<b>Date Identified: </b> #{date_identified}", :inline_format =>  true
    pdf.text "<b>Date resolved: </b> #{date_resolved}", :inline_format =>  true
    pdf.text "<b>description: </b> #{ActionView::Base.full_sanitizer.sanitize(description)}", :inline_format =>  true
  end
end
