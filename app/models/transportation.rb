class Transportation < ApplicationRecord
  belongs_to :user
  belongs_to :transportation_type, optional: true
  belongs_to :transportation_status, optional: true
  belongs_to :transportation_mean, optional: true
  belongs_to :transportation_accessibility, optional: true

  has_many :transportation_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :transportation_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id

  def self.enumeration_columns
    [
        ["#{TransportationType}", 'transportation_type_id'],
        ["#{TransportationMean}", 'transportation_mean_id'],
        ["#{TransportationStatus}", 'transportation_status_id']
    ]
  end

  def transportation_type
    if transportation_type_id
      super
    else
      TransportationType.default
    end
  end

  def transportation_status
    if transportation_status_id
      super
    else
      TransportationStatus.default
    end
  end

 def transportation_mean
    if transportation_mean_id
      super
    else
      TransportationMean.default
    end
  end

 def transportation_accessibility
    if transportation_accessibility_id
      super
    else
      TransportationAccessibility.default
    end
  end


  def to_s
    title
  end

  def self.safe_attributes
    [:user_id, :title, :transportation_mean_id, :transportation_type_id,
     :transportation_accessibility_id, :transportation_status_id,
     :description, :estimated_monthly_cost, :date_start,
     :date_end, transportation_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Transportation ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Title: </b> #{title}", :inline_format =>  true
    pdf.text "<b>Transportation Mean: </b> #{transportation_mean}", :inline_format =>  true
    pdf.text "<b>Transportation Type: </b> #{transportation_type}", :inline_format =>  true
    pdf.text "<b>Transportation Status: </b> #{transportation_status}", :inline_format =>  true
    pdf.text "<b>Transportation accessibility: </b> #{transportation_accessibility}", :inline_format =>  true
    pdf.text "<b>Estimated monthly cost: </b> #{estimated_monthly_cost}", :inline_format =>  true
    pdf.text "<b>Start date: </b> #{date_start}", :inline_format =>  true
    pdf.text "<b>End date: </b> #{date_end}", :inline_format =>  true
    pdf.text "<b>description: </b> #{ActionView::Base.full_sanitizer.sanitize(description)}", :inline_format =>  true
  end
  
end
