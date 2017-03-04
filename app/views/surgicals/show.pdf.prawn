prawn_document(:page_layout => :portrait) do |pdf|
  @surgical.to_pdf(pdf)

end