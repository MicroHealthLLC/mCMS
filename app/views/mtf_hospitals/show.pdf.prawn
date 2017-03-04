prawn_document(:page_layout => :portrait) do |pdf|
  @mtf_hospital.to_pdf(pdf)

end