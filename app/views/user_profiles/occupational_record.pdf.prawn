prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
   User.current.to_pdf_brief_info(pdf)

   if @educations.any?
     @educations.each do |object|
        object.to_pdf(pdf, false)
        pdf.move_down 20
     end
   end
   if @other_skills.any?
     pdf.start_new_page
     @other_skills.each do |object|
        object.to_pdf(pdf, false)
        pdf.move_down 20
     end
   end
   if @certifications.any?
    pdf.start_new_page
    @certifications.each do |object|
        object.to_pdf(pdf, false)
        pdf.move_down 20
    end
   end
   if @clearances.any?
        pdf.start_new_page
        @clearances.each do |object|
            object.to_pdf(pdf, false)
            pdf.move_down 20
        end
   end
   if @positions.any?
    pdf.start_new_page
    @positions.each do |object|
        object.to_pdf(pdf, false)
        pdf.move_down 20
    end
   end
   if @injuries.any?
    pdf.start_new_page
    @injuries.each do |object|
        object.to_pdf(pdf, false)
        pdf.move_down 20
    end
   end
   if @job_apps.any?
   pdf.start_new_page
    @job_apps.each do |object|
        object.to_pdf(pdf, false)
        pdf.move_down 20
    end
   end
   if @worker_compensations.any?
    pdf.start_new_page
        @worker_compensations.each do |object|
            object.to_pdf(pdf, false)
            pdf.move_down 20
        end
    end

end