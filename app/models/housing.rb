class Housing < ApplicationRecord
  belongs_to :user
  belongs_to :housing_status, :optional=> true
  belongs_to :housing_type, :optional=> true
  belongs_to :cohabitation_type, :optional=> true
  belongs_to :primary_address, :optional=> true, class_name: 'Address'

  has_many :housing_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :housing_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id


  def self.enumeration_columns
    [
        ["#{HousingStatus}", 'housing_status_id'],
        ["#{CohabitationType}", 'cohabitation_type_id'],
        ["#{HousingType}", 'housing_type_id']
    ]
  end

  def housing_status
    if housing_status_id
      super
    else
      HousingStatus.default
    end
  end

  def housing_type
    if housing_type_id
      super
    else
      HousingType.default
    end
  end

  def cohabitation_type
    if cohabitation_type_id
      super
    else
      CohabitationType.default
    end
  end

  def to_s
    title
  end

  def self.safe_attributes
    [:user_id, :title, :housing_type_id, :cohabitation_type_id,
     :housing_status_id, :description,
     :primary_address_id, :estimated_monthly_payment,
     :date_start, :date_end,
     housing_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Housing ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Title: </b> #{title}", :inline_format =>  true
    pdf.text "<b>Housing Type: </b> #{housing_type}", :inline_format =>  true
    pdf.text "<b>Housing Status: </b> #{housing_status}", :inline_format =>  true
    pdf.text "<b>Primary Address: </b> #{primary_address}", :inline_format =>  true
    pdf.text "<b>Cohabitation Type: </b> #{cohabitation_type}", :inline_format =>  true
    pdf.text "<b>Start date: </b> #{date_start}", :inline_format =>  true
    pdf.text "<b>End date: </b> #{date_end}", :inline_format =>  true
    pdf.text "<b>description: </b> #{ActionView::Base.full_sanitizer.sanitize(description)}", :inline_format =>  true
  end
  
end
