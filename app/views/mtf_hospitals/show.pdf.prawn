prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
  @mtf_hospital.to_pdf(pdf)

end