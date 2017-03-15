prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
  @insurance.to_pdf(pdf)
  render 'extend_demographies/show', :pdf=> pdf, extend_information: @insurance.extend_informations
end