prawn_document(:page_layout => :portrait) do |pdf|
  @teleconsult.to_pdf(pdf)
end