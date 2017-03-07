prawn_document(:page_layout => :portrait) do |pdf|
  @job_application.to_pdf(pdf)
end