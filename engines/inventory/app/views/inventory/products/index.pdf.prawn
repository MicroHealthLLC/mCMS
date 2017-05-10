prawn_document(:page_layout => :portrait) do |pdf|

  @products.each do |object|
    object.to_pdf(pdf, false)
    pdf.move_down 20
  end
end