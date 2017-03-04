class Award < ApplicationRecord
  belongs_to :user
  belongs_to :award_enum, optional: true
  belongs_to :award_type, optional: true

  has_many :award_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :award_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :award_enum_id, :user_id


  def self.enumeration_columns
    [
        ["#{AwardEnum}", 'award_type_id'],
        ["#{AwardType}", 'award_enum_id']
    ]
  end

  def award_enum
    if self.award_enum_id
      super
    else
      AwardEnum.default
    end
  end

  def award_type
    if self.award_type_id
      super
    else
      AwardType.default
    end
  end

  def to_s
    award_enum
  end

  def self.safe_attributes
    [
        :user_id, :award_type_id, :award_enum_id,
        :award_date, :note,
        award_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Award ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Award: </b> #{award_enum}", :inline_format =>  true
    pdf.text "<b>Award Type: </b> #{award_type}", :inline_format =>  true
    pdf.text "<b>Award date: </b> #{award_date}", :inline_format =>  true
    pdf.text "<b>Noyr: </b> #{ActionView::Base.full_sanitizer.sanitize(note)}", :inline_format =>  true
  end
  
end
