class DailyLiving < ApplicationRecord
  belongs_to :user

  belongs_to :daily_living_status, :optional=> true
  belongs_to :daily_living_type, :optional=> true
  validates_presence_of :user_id

  has_many :daily_living_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :daily_living_attachments, reject_if: :all_blank, allow_destroy: true

  def self.enumeration_columns
    [
        ["#{DailyLivingStatus}", 'daily_living_status_id'],
        ["#{DailyLivingType}", 'daily_living_type_id']
    ]
  end

  def daily_living_status
    if daily_living_status_id
      super
    else
      DailyLivingStatus.default
    end
  end

  def daily_living_type
    if daily_living_type_id
      super
    else
      DailyLivingType.default
    end
  end

  def to_s
    title
  end

  def self.safe_attributes
    [:title, :user_id, :daily_living_type_id,
     :daily_living_status_id, :description,
     :date_start, :date_end,
     daily_living_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf
    pdf.font_size(25){  pdf.text "Daily living ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Title: </b> #{title}", :inline_format =>  true
    pdf.text "<b>Description: </b> #{ActionView::Base.full_sanitizer.sanitize(description)}", :inline_format =>  true
    pdf.text "<b>Type: </b> #{daily_living_type}", :inline_format =>  true
    pdf.text "<b>Status: </b> #{daily_living_status}", :inline_format =>  true

  end

end
