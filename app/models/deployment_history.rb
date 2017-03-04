class DeploymentHistory < ApplicationRecord
  belongs_to :user
  belongs_to :deployment_operation, optional: true
  belongs_to :state, optional: true, class_name: 'StateType'
  belongs_to :country_type, optional: true

  has_many :deployment_history_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :deployment_history_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :deployment_operation_id


  def self.enumeration_columns
    [
        ["#{DeploymentOperation}", 'deployment_operation_id'],
        ["#{CountryType}", 'country_id'],
        ["#{StateType}", 'state_id']
    ]
  end

  def deployment_operation
    if self.deployment_operation_id
      super
    else
      DeploymentOperation.default
    end
  end

  def state
    if state_id
      super
    else
      StateType.default
    end
  end

  def country_type
    if country_id
      CountryType.find_by(id: country_id)
    else
      CountryType.default
    end
  end

  def to_s
    deployment_operation
  end

  def self.safe_attributes
    [
        :user_id, :deployment_operation_id,
        :location, :city, :state_id,
        :country_id, :date_start,
        :date_end, :note,
        deployment_history_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Deployment History ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Deployment Operation: </b> #{deployment_operation}", :inline_format =>  true
    pdf.text "<b>location: </b> #{location}", :inline_format =>  true
    pdf.text "<b>City: </b> #{city}", :inline_format =>  true
    pdf.text "<b>State: </b> #{state}", :inline_format =>  true
    pdf.text "<b>Country: </b> #{country_type}", :inline_format =>  true
    pdf.text "<b>Start date: </b> #{date_start}", :inline_format =>  true
    pdf.text "<b>End date: </b> #{date_end}", :inline_format =>  true
    pdf.text "<b>description: </b> #{ActionView::Base.full_sanitizer.sanitize(note)}", :inline_format =>  true
  end

end
