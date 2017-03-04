prawn_document(:page_layout => :portrait) do |pdf|
  @service_history.to_pdf(pdf)

end