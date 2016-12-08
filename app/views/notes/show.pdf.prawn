prawn_document(:page_layout => :portrait) do |pdf|
  @note.to_pdf(pdf)
end