prawn_document(:page_layout => :portrait) do |pdf|
  @environment_risk.to_pdf(pdf)

end