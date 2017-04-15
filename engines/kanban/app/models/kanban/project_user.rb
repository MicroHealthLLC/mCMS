module Kanban
  class ProjectUser < ApplicationRecord
    belongs_to :project
    belongs_to :user, class_name: 'User'
  end
end
