prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
   @daily_living.to_pdf(pdf)
end