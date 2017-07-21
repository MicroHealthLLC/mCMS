class CaseOrganization < ApplicationRecord
  belongs_to :organization
  belongs_to :case

  # belongs_to :association

  def association_type
    @association ||= (AssociationType.find_by(id: association_id) || AssociationType.default)
  end

  def self.safe_attributes
    [:case_id, :organization_id, :association_id]
  end

  def to_s
    id
  end

  def extend_informations
    organization.try(:extend_informations) || ExtendDemography.new
  end

  def to_pdf(pdf)
    org = self.organization
    pdf.font_size(25){  pdf.table([[ "Organization ##{org.id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    pdf.table([[ "CASE: ", " #{self.case}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Name ", " #{org.name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Organization type ", " #{org.organization_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(org.note)}"]], :column_widths => [ 150, 373])

  end

end
