class FamilyHistory < ApplicationRecord
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :family_type, optional: true
  belongs_to :family_status, optional: true

  has_many :family_history_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :family_history_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :name

  def self.enumeration_columns
    [
        ["#{FamilyType}", 'family_type_id'],
        ["#{FamilyStatus}", 'family_status_id']
    ]
  end

  def family_type
    if family_type_id
      super
    else
      FamilyType.default
    end
  end

  def family_status
    if family_status_id
      super
    else
      FamilyStatus.default
    end
  end

  def to_s
    name
  end

  def self.safe_attributes
    [:name, :user_id, :icdcm_code_id, :date_identified, :family_status_id,
     :family_type_id, :description]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Family History ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Name: </b> #{name}", :inline_format =>  true
    pdf.text "<b>Icdcm Code: </b> #{icdcm_code}", :inline_format =>  true
    pdf.text "<b>Family History Status: </b> #{family_status}", :inline_format =>  true
    pdf.text "<b>Family History Type: </b> #{family_type}", :inline_format =>  true
    pdf.text "<b>date identified: </b> #{date_identified}", :inline_format =>  true
    pdf.text "<b>description: </b> #{ActionView::Base.full_sanitizer.sanitize(description)}", :inline_format =>  true
  end
end
