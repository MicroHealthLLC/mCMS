namespace :enumeration do
  desc "Charge all enumeration"
  task random: :environment do
    puts 'creating enum'
    Enumeration.subclasses.each do |subclass|
      unless subclass.count > 2
        puts "creating enum for #{subclass.to_s}"
        (0..2).each do |i|
          subclass.create(name: "#{subclass.to_s[0..10]} #{i}", active: true)
        end
      end
    end
  end

  task print_subclasses: :environment do
    files =  Dir["app/models/enumerations/**/*.rb"].map{|file| file[24..-4] }
    files.sort.each do |file_name|
      puts "require_dependency '#{file_name}'"
    end
  end
end
