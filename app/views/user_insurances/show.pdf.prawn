prawn_document(:page_layout => :portrait) do |pdf|
  @user_insurance.to_pdf(pdf)
end