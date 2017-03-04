prawn_document(:page_layout => :portrait) do |pdf|
  @other_history.to_pdf(pdf)

end