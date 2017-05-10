prawn_document(:page_layout => :portrait) do |pdf|

  @product.to_pdf( pdf)
end