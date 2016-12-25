prawn_document(:page_layout => :portrait) do |pdf|
  @goal.to_pdf(pdf)
end