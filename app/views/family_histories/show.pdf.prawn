prawn_document(:page_layout => :portrait) do |pdf|
  @family_history.to_pdf(pdf)

end