# This migration comes from event_calendar (originally 20170816195334)
class AddUserToEventCalendarEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :event_calendar_events, :user_id, :integer
    add_index :event_calendar_events, :user_id
    events = EventCalendar::Event.where(nil)
    events.each do |event|
      user_id = event.audits.first.user_id rescue nil
      event.update(user_id: user_id)
    end
  end
end
