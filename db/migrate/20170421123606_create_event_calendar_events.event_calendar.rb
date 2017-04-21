# This migration comes from event_calendar (originally 20170421122226)
class CreateEventCalendarEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :event_calendar_events do |t|
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
