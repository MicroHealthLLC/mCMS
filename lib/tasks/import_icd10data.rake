namespace :icddata do
  desc "Charge all enumeration"
  task import_data: :environment do
    puts 'creating icddata'
    doc = File.open("document.xml") { |f| Nokogiri::XML(f) }
    diags = doc.xpath('//diag')
    diags.each do |d|
      hash = {}

      hash[:childrens] = d.css('name').map(&:children).map(&:to_s)[1..-1].join('/')
      hash[:name] = d.css('name').first.children.to_s
      hash[:description] = d.css('desc').first.children.to_s
      Icd10datum.create(hash)
    end
  end
end