prawn_document(:page_layout => :portrait) do |pdf|
  @appointment.to_pdf(pdf)

end