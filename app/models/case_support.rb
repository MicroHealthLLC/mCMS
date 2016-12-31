class CaseSupport < ApplicationRecord
  belongs_to :case_support_type, optional: true
  belongs_to :user
  belongs_to :case
  has_one :case_support_extend_demography

  has_many :case_support_attachments, foreign_key: :owner_id
  accepts_nested_attributes_for :case_support_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :case_id, :user_id

  def extend_informations
    case_support_extend_demography || CaseSupportExtendDemography.new(case_support_id: self.id)
  end

  def case_support_type
    if case_support_type_id
      super
    else
      CaseSupportType.default
    end
  end

  def self.safe_attributes
    [
        :first_name, :middle_name, :last_name, :case_id,
        :note, :case_support_type_id, :user_id,
        case_support_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def name
    "#{first_name} #{middle_name} #{last_name}".tr('  ', ' ')
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Case Support  ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
     pdf.text "<b>Name: </b> #{name}", :inline_format =>  true
    pdf.text "<b>Note: </b> #{ActionView::Base.full_sanitizer.sanitize(note)}", :inline_format =>  true
  end

  def for_mail
    output = ""
    output<< "<h2>Case Support ##{id} </h2>"
    output<< "<b>Name: </b> #{name}<br/>"
    output<< "<b>Note: </b> #{note}<br/>"
    output.html_safe
  end

end
