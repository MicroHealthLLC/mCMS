class AddTimelineToModule < ActiveRecord::Migration[5.0]
  def change
    EnabledModule.where(name: 'timeline').first_or_create
  end
end
