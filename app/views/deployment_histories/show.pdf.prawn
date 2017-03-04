prawn_document(:page_layout => :portrait) do |pdf|
  @deployment_history.to_pdf(pdf)

end