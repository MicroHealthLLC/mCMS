prawn_document(:page_layout => :portrait) do |pdf|
  User.current.to_pdf_organization(pdf)
  User.current.to_pdf_brief_info(pdf)
   pdf.move_down 40
  @jsignatures.each do |object|
    object.to_pdf(pdf, "Signature ##{object.id}")
    pdf.move_down 20
  end
end