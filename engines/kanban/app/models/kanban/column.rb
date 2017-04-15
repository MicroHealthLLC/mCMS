module Kanban
  class Column < ApplicationRecord
    serialize :settings
    belongs_to :project
    default_scope -> {order('position ASC')}
    has_many :cards, -> { where is_archived: false } , dependent: :destroy

    validates_presence_of :name, :project_id
    validates_uniqueness_of :name, scope: :project_id

    after_create :update_position
    after_create :update_project

    def update_position
      Column.where(project_id: self.project_id).
          where('position>= ?', self.position).
          where('id != ?', self.id).update_all("position = position +1")
    end

    def update_project
      project.update(number_of_columns: project.number_of_columns += 1)
    end

    before_destroy do
      project.update(number_of_columns: project.number_of_columns -= 1)
    end

    def cards_active
      cards.where(is_archived: false)
    end

    def to_json
      {
          id: self.id,
          name: self.name,
          setting: settings,
          cards: self.cards_active.map(&:to_json)
      }
    end
  end
end
