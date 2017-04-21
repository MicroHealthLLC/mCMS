class AddEventToEnabledModule < ActiveRecord::Migration[5.0]
  def change
    EnabledModule.create(name: 'events')
  end
end
