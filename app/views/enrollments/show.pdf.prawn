prawn_document(:page_layout => :portrait) do |pdf|
 @enrollment.to_pdf(pdf)
end