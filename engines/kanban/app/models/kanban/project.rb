module Kanban
  class Project < ApplicationRecord
    serialize :settings
    has_many :cards, dependent: :destroy
    has_many :columns, dependent: :destroy

    has_many :project_users
    # accepts_nested_attributes_for :project_users

    after_create do
      (1..number_of_columns).each do |idx|
        Column.create(name: "Column #{idx}", project_id: self.id, position: idx)
      end
    end

    validates_presence_of :name, :number_of_columns
    validates_uniqueness_of :name

    def cards_archived
      cards.where(is_archived: true)
    end

    def cards_active
      cards.where(is_archived: false)
    end

    def to_json
      {
          self.name => {
              id: self.id,
              name: self.name,
              "numberOfColumns"=> self.columns.count,
              columns: columns.map(&:to_json),
              archived: self.cards_archived.map(&:archived_to_json),
              settings: {}
          }
      }
    end

    def for_local_storage
      json = { "kanbans" =>  self.to_json }
      json = json.merge({
                            "lastUsed"=>   self.name,
                            "theme"=>   "default-bright",
                            "lastUpdated" => 0
                        })
      json
    end

    def self.default_local_storage
      json = { "kanbans" =>  {} }
      json = json.merge({
                            "lastUsed"=>   '',
                            "theme"=>   "default-bright",
                            "lastUpdated" => 0
                        })
      json
    end
  end
end
