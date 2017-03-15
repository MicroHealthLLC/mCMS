prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
  User.current.to_pdf_brief_info(pdf)

     if @admissions
  @admissions.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @problem_lists
   pdf.start_new_page
 @problem_lists.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @health_care_facilities
   pdf.start_new_page
 @health_care_facilities.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @surgicals
   pdf.start_new_page
 @surgicals.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @medicals
   pdf.start_new_page
 @medicals.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @medications
   pdf.start_new_page
 @medications.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @behavioral_risks
   pdf.start_new_page
 @behavioral_risks.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @family_histories
   pdf.start_new_page
 @family_histories.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
    end
    if @immunizations
   pdf.start_new_page
 @immunizations.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
    end
    if @allergies
   pdf.start_new_page
 @allergies.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
    end

end