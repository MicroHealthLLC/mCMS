prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
   User.current.to_pdf_brief_info(pdf)
   pdf.table([[ "Survey: ", " #{@survey.name}"]], :column_widths => [ 150, 373])
   pdf.table([[ "Description: ", " #{ActionView::Base.full_sanitizer.sanitize( @survey.description)}"]], :column_widths => [ 150, 373])
   pdf.move_down(10)
   @attempts.each do |object|
     object.to_pdf(pdf)
     pdf.start_new_page
   end
end