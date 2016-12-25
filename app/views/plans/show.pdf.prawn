prawn_document(:page_layout => :portrait) do |pdf|
  @plan.to_pdf(pdf)
end