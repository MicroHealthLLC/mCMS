prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
  User.current.to_pdf_brief_info(pdf)

     if @educations
  @educations.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @other_skills
   pdf.start_new_page
 @other_skills.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @certifications
   pdf.start_new_page
 @certifications.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @clearances
   pdf.start_new_page
 @clearances.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @positions
   pdf.start_new_page
 @positions.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @injuries
   pdf.start_new_page
 @injuries.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @job_applications
   pdf.start_new_page
 @job_applications.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @worker_compensations
   pdf.start_new_page
 @worker_compensations.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
    end

end