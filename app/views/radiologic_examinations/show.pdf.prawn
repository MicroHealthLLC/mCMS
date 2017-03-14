prawn_document(:page_layout => :portrait) do |pdf|
  @radiologic_examination.to_pdf(pdf)
end