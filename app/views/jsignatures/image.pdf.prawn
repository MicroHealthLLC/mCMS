prawn_document(:page_layout => :portrait) do |pdf|
  @jsignature.render_signature(pdf)
end