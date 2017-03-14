prawn_document(:page_layout => :portrait) do |pdf|
  if User.current.can?(:manage_roles)
      @cases.each_with_index do |object, idx|
        object.to_pdf(pdf)
         pdf.start_new_page if idx < @cases.count
      end
  else
   User.current.to_pdf_brief_info(pdf)
    @cases.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
    end
  end

end