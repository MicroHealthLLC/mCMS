module EventCalendar
  class Event < ApplicationRecord
    audited
    validates_presence_of :name, :start_time, :end_time

    def self.safe_attributes
      [:name, :description, :start_time, :end_time]
    end

    def guess_path
      "/events_calendar/events/#{self.id}"
    end
  end
end
