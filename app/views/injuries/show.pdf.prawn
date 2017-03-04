prawn_document(:page_layout => :portrait) do |pdf|
  @injury.to_pdf(pdf)

end