class AddColorToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :event_calendar_events, :color, :string
  end
end
