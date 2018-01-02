# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
Rails.application.config.assets.precompile += %w( .svg .eot .woff .ttf)
#CSS
Rails.application.config.assets.precompile += %w(kanban/themes/default-bright.css sticky.css /home/bilel/Desktop/redmine_projects/redmine-3.3.0 jquery.tagsinput.css)
#JS
Rails.application.config.assets.precompile += %w(smart_admin/* chat.js signature.js lightbox2.css lightbox2.js jquery.tagsinput.js form_builder/form-builder.min.js form_builder/form-render.min.js)
