prawn_document(:page_layout => :portrait) do |pdf|
  @medication.to_pdf(pdf)

end