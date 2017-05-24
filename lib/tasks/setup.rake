namespace :icddata do
  task make: :environment do

    puts 'Add modules'
    modules = []
    modules += %w{affiliations clearances certifications contacts educations}
    modules += %w{other_skills positions languages tasks documents}
    modules += %w{plans goals needs}
    modules += %w{checklists surveys cases}
    modules += %w{appointments forum wiki news insurances}
    modules += ['new_conference', 'chat_room', 'my_cases', 'my_appointments']
    modules += ['my_tasks', 'subcases', 'notes', 'watchers', 'case_support']
    modules += ['user_subscription', 'all_files']
    modules += ['client_journals', 'enrollments', 'teleconsults', 'daily_livings']
    modules += ['admissions', 'housings', 'health_care_facilities']
    modules += ['legals', 'transportations', 'financials']
    modules += ['service_histories', 'deployment_histories',
                'units', 'awards',
                'incident_histories', 'mtf_hospitals']
    modules.each do |em|
      EnabledModule.where(name: em).first_or_create
    end
    puts 'All modules are set'


    file = "immunization.xlsx"
    puts "import #{file}"
    s = SpreadsheetEnumerationUpload.new file
    s.upload_immunization_cvx


    # task hcpc
    file = "HCPC.xlsx"
    puts "import #{file}"
    s = SpreadsheetEnumerationUpload.new file
    s.upload_hcpc


    # task update_hcpc:
    file = "hcpc_code.csv"
    puts "import #{file}"
    s = SpreadsheetEnumerationUpload.new file
    s.update_hcpc

    # task occupation:
    file = "occupation.xls"
    puts "import #{file}"
    s = SpreadsheetEnumerationUpload.new file
    s.occupation_import


    # task place_of_service:
    file = "Place of Service.xlsx"
    s = SpreadsheetEnumerationUpload.new file
    s.upload_place_of_service

    puts 'creating icddata'
    file = "document.xml"
    puts "import #{file}"
    doc = File.open(file) { |f| Nokogiri::XML(f) }
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