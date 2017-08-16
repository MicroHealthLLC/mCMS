module EventCalendar
  class Event < ApplicationRecord
    audited
    validates_presence_of :name, :start_time, :end_time

    def self.safe_attributes
      [:name, :user_id, :description, :start_time, :end_time, :color]
    end

    def self.my
      where(user_id: User.current.id)
    end

    def color
      return super if super
      'bg-color-blue txt-color-white'
    end

    def guess_path
      "/events_calendar/events/#{self.id}"
    end
  end
end
