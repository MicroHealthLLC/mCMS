class AddUserToEventCalendarEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :event_calendar_events, :user_id, :integer
    add_index :event_calendar_events, :user_id
  end
end
