prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
  @organization.to_pdf(pdf)

  render 'extend_demographies/show', :pdf=> pdf, extend_information: @organization.extend_informations

end