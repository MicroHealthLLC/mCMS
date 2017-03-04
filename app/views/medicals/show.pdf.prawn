prawn_document(:page_layout => :portrait) do |pdf|
  @medical.to_pdf(pdf)

end