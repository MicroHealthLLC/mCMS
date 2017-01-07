namespace :modules do
  desc "Charge all modules"
  task pull_modules: :environment do
    puts 'Setting all modules activities'
    modules = []
    modules += %w{affiliations clearances certifications contacts educations other_skills positions languages tasks documents}
    modules += %w{plans goals needs}
    modules += %w{checklists surveys cases}
    modules += %w{appointments forum wiki news insurances}
    modules += ['new_conference', 'chat_room', 'my_cases', 'my_appointments', 'my_tasks', 'subcases', 'notes', 'watchers', 'case_support']
    modules += ['user_subscription']
    modules.each do |em|
      EnabledModule.where(name: em).first_or_create
    end
    puts 'All modules are set'
  end

  task delete_modules: :environment do
    modules = ['', 'posts', 'Chat_room', 'case_suport']
    modules.each do |em|
      EnabledModule.where(name: em).delete_all
    end
  end



end
