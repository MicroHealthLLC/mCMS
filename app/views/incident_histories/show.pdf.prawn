prawn_document(:page_layout => :portrait) do |pdf|
  @incident_history.to_pdf(pdf)

end