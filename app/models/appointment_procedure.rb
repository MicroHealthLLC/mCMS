class AppointmentProcedure < ApplicationRecord
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
    procedure
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

end
