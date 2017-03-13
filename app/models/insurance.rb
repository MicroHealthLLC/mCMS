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

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Insurance ##{id}"]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})}
    pdf.table([["Insurance "]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "name: ", " #{name}"]], :column_widths => [ 150, 373])
  end
end
