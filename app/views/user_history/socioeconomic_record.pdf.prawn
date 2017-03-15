prawn_document(:page_layout => :portrait) do |pdf|
   User.current.to_pdf_organization(pdf)
  User.current.to_pdf_brief_info(pdf)

     if @daily_livings
  @daily_livings.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @socioeconomics
   pdf.start_new_page
 @socioeconomics.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @environment_risks
   pdf.start_new_page
 @environment_risks.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @housings
   pdf.start_new_page
 @housings.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @financials
   pdf.start_new_page
 @financials.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @legals
   pdf.start_new_page
 @legals.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @transportations
   pdf.start_new_page
 @transportations.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
   end
     if @other_histories
   pdf.start_new_page
 @other_histories.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
    end


end