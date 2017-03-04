prawn_document(:page_layout => :portrait) do |pdf|
  @legal.to_pdf(pdf)

end