prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
   @case.to_pdf( pdf)
   pdf.start_new_page  if @cases.present?
   @cases.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
    end
    pdf.start_new_page  if @notes.present?
   @notes.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
    end
    pdf.start_new_page  if @needs.present?
   @needs.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
    end
    pdf.start_new_page  if @goals.present?
   @goals.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
    end
    pdf.start_new_page  if @plans.present?
   @plans.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
    end
    pdf.start_new_page  if @tasks.present?
   @tasks.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
    end
    pdf.start_new_page  if @documents.present?
   @documents.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
    end
    pdf.start_new_page  if @enrollments.present?
   @enrollments.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
    end
  pdf.start_new_page  if @teleconsults.present?
   @teleconsults.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
    end
   pdf.start_new_page  if @checklists.present?
   @checklists.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
    end
  pdf.start_new_page  if @appointments.present?
   @appointments.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
    end

  pdf.start_new_page  if @referrals.present?
   @referrals.each do |object|
      object.to_pdf(pdf, false)
      pdf.move_down 20
    end
  pdf.start_new_page  if @jsignatures.present?
   @jsignatures.each do |object|
      object.to_pdf(pdf, "Plan of Care Agreement")
      pdf.move_down 20
    end
end