class AddLmsToModule < ActiveRecord::Migration[5.0]
  def change
    EnabledModule.create(name: 'lms/pages')
  end
end
