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
    pdf.font_size(25){  pdf.table([[ "Deployment History ##{id}"]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf)
    pdf.table([[ "Deployment Operation: ", " #{deployment_operation}"]], :column_widths => [ 150, 373])
    pdf.table([[ "location: ", " #{location}"]], :column_widths => [ 150, 373])
    pdf.table([[ "City: ", " #{city}"]], :column_widths => [ 150, 373])
    pdf.table([[ "State: ", " #{state}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Country: ", " #{country_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Start date: ", " #{date_start}"]], :column_widths => [ 150, 373])
    pdf.table([[ "End date: ", " #{date_end}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

end
