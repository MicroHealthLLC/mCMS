prawn_document(:page_layout => :portrait) do |pdf|
  @laboratory_examination.to_pdf(pdf)
end