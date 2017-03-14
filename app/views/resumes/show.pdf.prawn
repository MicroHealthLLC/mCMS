prawn_document(:page_layout => :portrait) do |pdf|
  @resume.to_pdf(pdf)

end