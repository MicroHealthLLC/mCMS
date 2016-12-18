prawn_document(:page_layout => :portrait) do |pdf|
  @insurance.to_pdf(pdf)

 render 'extend_demographies/show', :pdf=> pdf, extend_information: @insurance.extend_informations

end