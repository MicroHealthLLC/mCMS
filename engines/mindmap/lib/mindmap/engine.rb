module Mindmap
  class Engine < ::Rails::Engine
    isolate_namespace Mindmap
    initializer 'mindmap.setup_assets' do
      Rails.application.config.assets.precompile += %w( mindmap/*)
    end
  end
end
