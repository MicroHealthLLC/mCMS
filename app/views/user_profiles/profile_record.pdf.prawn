prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
    User.current.to_pdf( pdf)
    pdf.move_down 10
    render 'extend_demographies/show', :pdf=> pdf, extend_information: User.current.extend_informations
   if @languages
     pdf.start_new_page
     @languages.each do |object|
       object.to_pdf(pdf, false)
       pdf.move_down 20
     end
   end
   pdf.start_new_page
   if @affiliations
     @affiliations.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
    end
   end
   if @contacts
     pdf.start_new_page
     @contacts.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
     end
   end
   if @user_insurances
     pdf.start_new_page
     @user_insurances.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
    end
   end
   if @documents
     pdf.start_new_page
     @documents.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
    end
   end

end