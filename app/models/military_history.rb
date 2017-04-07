class MilitaryHistory < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :service_status, optional: true
  belongs_to :service_type, optional: true

  validates_presence_of :text, :user_id


  def self.enumeration_columns
    [
        ["#{ServiceStatus}", 'service_status_id'],
        ["#{ServiceType}", 'service_type_id']
    ]
  end

  def service_status
    super || ServiceStatus.default
  end

  def service_type
    super || ServiceType.default
  end

  def to_s
    text
  end

  def self.safe_attributes
    [
        :user_id, :text, :service_type_id, :service_status_id,
        :date_started, :date_ended, :note
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Military History ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Military History "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Texte: ", " #{text}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Service Type: ", " #{service_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Service Status: ", " #{service_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date started: ", " #{date_started}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date ended: ", " #{date_ended}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end
end
