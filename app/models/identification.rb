class Identification < ApplicationRecord
  belongs_to :identification_type, optional: true
  belongs_to :issued_by_type, optional: true

  validates_presence_of :identification_number, :identification_type_id
  validates_uniqueness_of :identification_type_id, scope: [:extend_demography_id]

  def self.include_enumerations
    includes(:issued_by_type_id, :status, :identification_type_id).
        references(:issued_by_type_id, :status, :identification_type_id)
  end

  def self.safe_attributes
    [:id, :identification_number, :status, :date_expired, :issued_by_type_id, :date_issued, :note, :identification_type_id, :_destroy]
  end

  def identification_type
    if identification_type_id
      super
    else
      IdentificationType.default
    end
  end

 def issued_by_type
    if issued_by_type_id
      super
    else
      IssuedByType.default
    end
  end



  def to_pdf(pdf, show_user = true)
    pdf.table([[ "Identification type:", " #{identification_type}", " Id number:", " #{identification_number}"]], :column_widths => [ 100,150, 100, 173])
  end

end
