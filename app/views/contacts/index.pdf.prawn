prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
  User.current.to_pdf_brief_info(pdf)
  @contacts.each do |object|
    object.to_pdf(pdf, false)
    render 'extend_demographies/show', :pdf=> pdf, extend_information: object.extend_informations
    pdf.move_down 20
  end
end