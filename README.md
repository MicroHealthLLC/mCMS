# README

INSTALLATION:
- use ruby 2.3.1
- rails 5.0.0.1
- install image_magick => apt-get install imagemagick
- install Redis for chatting system
- Install JDK v 1.8
- Install Unzip
- git pull into your directory
- Setup Database rake db:create rake db:setup rake db:migrate
- For Omniauth add your keys in config/application.yml and add use URL to CALLBACK_URL
- Recaptcha too
- ADD YOUR URL TO config/environments/production.rb for ActionCable URL
- Configure your email smtp
- start search services rake sunspot:solr:start RAILS_ENV=production
- start your app rails s -e production -b localhost -d
