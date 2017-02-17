# README

INSTALLATION:
- Install ruby 2.3.1
- Install rails 5.0.0.1
- Install Mysql
- install imagemagick
- install Redis for chatting system
- Install JDK v 1.8
- Install Unzip
- Install git
- Git clone this repo into your web directory
- Setup Database rake db:create rake db:setup rake db:migrate
- For Omniauth add your keys in config/application.yml and add use URL to CALLBACK_URL
- Recaptcha too
- ADD YOUR URL TO config/environments/production.rb for ActionCable URL
- Configure your email smtp
- Run Bundle Install from the directory you did a git clone
- import the ICD10 data rails icddata:import_data RAILS_ENV=production
- start search services rake sunspot:solr:start RAILS_ENV=production
- start your app rails s -e production -b localhost -d
