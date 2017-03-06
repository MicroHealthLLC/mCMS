class AppointmentDisposition < ApplicationRecord
  belongs_to :disposition, optional: true
  belongs_to :disposition_related_to, optional: true, foreign_key: :related_to_id
  belongs_to :user
  belongs_to :appointment

  validates_presence_of :user_id, :appointment_id, :note

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

end
