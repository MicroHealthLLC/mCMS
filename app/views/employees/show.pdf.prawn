prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
  @employee.to_pdf( pdf)
  pdf.move_down 10
  render 'extend_demographies/show', :pdf=> pdf, extend_information: @employee.extend_informations
end