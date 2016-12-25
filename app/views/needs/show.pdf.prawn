prawn_document(:page_layout => :portrait) do |pdf|
  @need.to_pdf(pdf)
end