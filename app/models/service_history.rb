class ServiceHistory < ApplicationRecord
  belongs_to :user
  belongs_to :service_status, optional: true
  belongs_to :service_type, optional: true
  belongs_to :rank, optional: true
  belongs_to :discharge_type, optional: true
  belongs_to :component, optional: true

  has_many :service_history_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :service_history_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :service_type_id, :user_id


  def self.enumeration_columns
    [
        ["#{ServiceStatus}", 'service_status_id'],
        ["#{ServiceType}", 'service_type_id'],
        ["#{DischargeType}", 'rank_id'],
        ["#{Component}", 'discharge_type_id'],
        ["#{Rank}", 'component_id']
    ]
  end

  def service_status
    super || ServiceStatus.default
  end

  def service_type
    super || ServiceType.default
  end

 def rank
    super || Rank.default
  end

 def discharge_type
    super || DischargeType.default
  end

 def component
    super || Component.default
  end

  def to_s
    service_type
  end

  def self.safe_attributes
    [
        :user_id, :rank_id, :service_type_id,
        :service_status_id, :component_id, :discharge_type_id,
        :date_entered, :end_active_obliged_service,
        :demobilization, :separation,
        :temporary_disability_retirement_list,
        :permanent_disability_retirement_list,
        :note,
        service_history_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Service History ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Service Type: </b> #{service_type}", :inline_format =>  true
    pdf.text "<b>Service Status: </b> #{service_status}", :inline_format =>  true
    pdf.text "<b>Service Rank: </b> #{rank}", :inline_format =>  true
    pdf.text "<b>Component: </b> #{component}", :inline_format =>  true
    pdf.text "<b>Discharge Type: </b> #{discharge_type}", :inline_format =>  true
    pdf.text "<b>Date entered: </b> #{date_entered}", :inline_format =>  true
    pdf.text "<b>End Active Obliged Service: </b> #{end_active_obliged_service}", :inline_format =>  true
    pdf.text "<b>Demobilization: </b> #{demobilization}", :inline_format =>  true
    pdf.text "<b>Separation: </b> #{separation}", :inline_format =>  true
    pdf.text "<b>Temporary disability retirement list: </b> #{temporary_disability_retirement_list}", :inline_format =>  true
    pdf.text "<b>Permanent disability retirement list: </b> #{permanent_disability_retirement_list}", :inline_format =>  true

    pdf.text "<b>description: </b> #{ActionView::Base.full_sanitizer.sanitize(note)}", :inline_format =>  true
  end

end
