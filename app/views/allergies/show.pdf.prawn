prawn_document(:page_layout => :portrait) do |pdf|
  @allergy.to_pdf(pdf)

end