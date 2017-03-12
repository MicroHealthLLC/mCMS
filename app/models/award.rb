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
    pdf.font_size(25){  pdf.table([[ "Award ##{id}"]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf)
    pdf.table([[ "Award: ", " #{award_enum}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Award Type: ", " #{award_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Award date: ", " #{award_date}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Noyr: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end
  
end
