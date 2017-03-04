prawn_document(:page_layout => :portrait) do |pdf|
  @checklist_case.to_pdf(pdf)

end