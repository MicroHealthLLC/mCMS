prawn_document(:page_layout => :portrait) do |pdf|
  @health_care_facility.to_pdf(pdf)
end