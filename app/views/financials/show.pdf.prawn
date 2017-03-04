prawn_document(:page_layout => :portrait) do |pdf|
  @financial.to_pdf(pdf)

end