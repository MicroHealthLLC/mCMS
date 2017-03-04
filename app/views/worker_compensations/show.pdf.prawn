prawn_document(:page_layout => :portrait) do |pdf|
  @worker_compensation.to_pdf(pdf)

end