prawn_document(:page_layout => :portrait) do |pdf|
  @immunization.to_pdf(pdf)

end