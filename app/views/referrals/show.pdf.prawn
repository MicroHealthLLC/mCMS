prawn_document(:page_layout => :portrait) do |pdf|
  @referral.to_pdf(pdf)

end