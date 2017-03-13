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
    pdf.font_size(25){  pdf.table([[ "Service History ##{id}"]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) ; pdf.table([["Informations Data "]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Service Type: ", " #{service_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Service Status: ", " #{service_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Service Rank: ", " #{rank}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Component: ", " #{component}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Discharge Type: ", " #{discharge_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date entered: ", " #{date_entered}"]], :column_widths => [ 150, 373])
    pdf.table([[ "End Active Obliged Service: ", " #{end_active_obliged_service}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Demobilization: ", " #{demobilization}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Separation: ", " #{separation}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Temporary disability retirement list: ", " #{temporary_disability_retirement_list}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Permanent disability retirement list: ", " #{permanent_disability_retirement_list}"]], :column_widths => [ 150, 373])

    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

end
