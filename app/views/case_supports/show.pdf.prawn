prawn_document(:page_layout => :portrait) do |pdf|
  @case_support.to_pdf( pdf)
end