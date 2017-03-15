prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
  @laboratory_examination.to_pdf(pdf)
end