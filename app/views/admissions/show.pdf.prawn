prawn_document(:page_layout => :portrait) do |pdf|
  @admission.to_pdf(pdf)

end