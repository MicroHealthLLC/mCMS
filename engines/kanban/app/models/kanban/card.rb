module Kanban
  class Card < ApplicationRecord
    belongs_to :column
    belongs_to :project

    validates_presence_of :name, :column_id, :project_id

    def to_json
      {
          id: self.id,
          name: self.name,
          details: self.description,
          color: self.color,
          startdate: self.start_date,
          duedate: self.due_date,
          archived_on: self.archived_on,
          completedate: self.date_completed
      }
    end
  end
end
