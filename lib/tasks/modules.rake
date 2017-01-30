namespace :modules do
  desc "Charge all modules"
  task pull_modules: :environment do
    modules = ['', 'posts', 'case_suport']
    modules.each do |em|
      EnabledModule.where(name: em).delete_all
    end

    puts 'Setting all modules activities'
    modules = []
    modules += %w{affiliations clearances certifications contacts educations}
    modules += %w{other_skills positions languages tasks documents}
    modules += %w{plans goals needs}
    modules += %w{checklists surveys cases}
    modules += %w{appointments forum wiki news insurances}
    modules += ['new_conference', 'chat_room', 'my_cases', 'my_appointments']
    modules += ['my_tasks', 'subcases', 'notes', 'watchers', 'case_support']
    modules += ['user_subscription', 'all_files']
    modules += ['client_journals']
    modules.each do |em|
      EnabledModule.where(name: em).first_or_create
    end
    puts 'All modules are set'
  end

  task delete_modules: :environment do

  end



end
