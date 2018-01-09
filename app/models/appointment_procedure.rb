class AppointmentProcedure < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :procedure, optional: true
  belongs_to :user
  belongs_to :provider, class_name: 'User'
  belongs_to :appointment
  belongs_to :hcpc
  belongs_to :em_code,  optional: true
  belongs_to :emergency,  optional: true
  belongs_to :epsdt,  optional: true
  validates_presence_of :user_id, :appointment_id, :note

  def self.safe_attributes
    [
        :user_id, :appointment_id, :modifier, :procedure_id,
        :note, :date_recorded, :hcpc_id, :em_code_id,
        :unit, :diagnosis_pointer, :epsdt_id, :emergency_id, :charges,
        :provider_id

    ]
  end

  def to_s
    hcpc
  end

  def em_code
    if em_code_id
      super
    else
      EmCode.default
    end
  end

  def emergency
    if emergency_id
      super
    else
      Emergency.default
    end
  end

 def epsdt
    if epsdt_id
      super
    else
      Epsdt.default
    end
  end


  def procedure
    if procedure_id
      super
    else
      Procedure.default
    end
  end

  def to_pdf(pdf, show_user= true)
    pdf.font_size(25){  pdf.table([[ "Procedure ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    pdf.table([[ "Procedure: ", " #{procedure}"]], :column_widths => [ 150, 373])
    pdf.table([[ "HCPCS: ", " #{hcpc}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Emergency: ", " #{emergency}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Provider: ", " #{provider}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Modifier: ", " #{modifier}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Charges: ", " #{charges}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Unit: ", " #{unit}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Diagnosis Pointer: ", " #{diagnosis_pointer}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])

  end

end
