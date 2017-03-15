prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
  User.current.to_pdf( pdf)
  pdf.move_down 10
  render 'extend_demographies/show', :pdf=> pdf, extend_information: User.current.extend_informations
end