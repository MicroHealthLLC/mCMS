prawn_document(:page_layout => :portrait) do |pdf|
  @unit.to_pdf(pdf)

end