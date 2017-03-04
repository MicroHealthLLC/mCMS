prawn_document(:page_layout => :portrait) do |pdf|
  @socioeconomic.to_pdf(pdf)

end