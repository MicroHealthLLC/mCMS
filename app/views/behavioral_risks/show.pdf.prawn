prawn_document(:page_layout => :portrait) do |pdf|
  @behavioral_risk.to_pdf(pdf)

end