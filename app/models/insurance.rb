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
    pdf.font_size(25){  pdf.table([[ "Affiliation ##{id}"]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) ; pdf.table([["Informations Data "]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "name: ", " #{name}"]], :column_widths => [ 150, 373])
  end
end
