class Insurance < ApplicationRecord

  has_one :insurance_extend_demography, :dependent => :destroy

  def self.safe_attributes
    [:name]
  end

  def extend_informations
    insurance_extend_demography || InsuranceExtendDemography.new(insurance_id: self.id)
  end

  def to_s
    name
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Affiliation ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>name: </b> #{name}", :inline_format =>  true
  end
end
