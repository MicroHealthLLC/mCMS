prawn_document(:page_layout => :portrait) do |pdf|
  @billing.to_pdf(pdf)

end