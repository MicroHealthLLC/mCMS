class AppointmentDisposition < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :disposition, optional: true
  belongs_to :disposition_related_to, optional: true, foreign_key: :related_to_id
  belongs_to :user
  belongs_to :appointment

  validates_presence_of :user_id, :appointment_id, :note, :disposition_id

  def self.safe_attributes
    [
        :user_id, :appointment_id, :disposition_id, :note, :date_recorded, :related_to_id
    ]
  end


  def to_s
    disposition
  end

  def related_to
    if related_to_id
      disposition_related_to
    else
      DispositionRelatedTo.default
    end
  end

  def disposition
    if disposition_id
      super
    else
      Disposition.default
    end
  end

  def to_pdf(pdf, show_user= true)
    pdf.font_size(25){  pdf.table([[ "Disposition ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    pdf.table([[ "Disposition: ", " #{disposition}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Related To: ", " #{related_to}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date Recorded: ", " #{date_recorded}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])

  end

end
