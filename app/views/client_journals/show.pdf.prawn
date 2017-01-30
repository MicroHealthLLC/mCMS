prawn_document(:page_layout => :portrait) do |pdf|
   @client_journal.to_pdf(pdf)
end