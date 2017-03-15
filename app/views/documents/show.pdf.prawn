prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
 @document.to_pdf(pdf)
end