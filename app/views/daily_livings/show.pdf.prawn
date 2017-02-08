prawn_document(:page_layout => :portrait) do |pdf|
   @daily_living.to_pdf(pdf)
end