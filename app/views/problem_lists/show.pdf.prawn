prawn_document(:page_layout => :portrait) do |pdf|
  @problem_list.to_pdf(pdf)

end