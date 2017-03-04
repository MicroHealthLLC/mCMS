prawn_document(:page_layout => :portrait) do |pdf|
  @housing.to_pdf(pdf)

end