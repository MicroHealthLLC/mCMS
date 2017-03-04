prawn_document(:page_layout => :portrait) do |pdf|
  @transportation.to_pdf(pdf)

end