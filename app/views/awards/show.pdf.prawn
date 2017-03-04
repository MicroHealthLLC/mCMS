prawn_document(:page_layout => :portrait) do |pdf|
  @award.to_pdf(pdf)

end