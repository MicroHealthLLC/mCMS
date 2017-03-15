prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
  @affiliation.to_pdf(pdf)

 render 'extend_demographies/show', :pdf=> pdf, extend_information: @affiliation.extend_informations

end