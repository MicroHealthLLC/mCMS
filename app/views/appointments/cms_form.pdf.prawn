prawn_document(:page_layout => :portrait) do |pdf|
pdf.
  h = pdf.cursor
   InsuranceType.all.each_with_index do |it, idx|
     pdf.bounding_box([idx*35, h], width: 35, height: 40) do
      checkbox(pdf, false, idx*35)
     end
   end
   InsuranceType.all.each_with_index do |it, idx|
     pdf.formatted_text_box [
       { :text => it.name, :font => "Courier" },
       ], :at => [idx*70 + 12, h - 5], :width =>  50
   end
end