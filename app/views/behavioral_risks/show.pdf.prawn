prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
  @behavioral_risk.to_pdf(pdf)

end