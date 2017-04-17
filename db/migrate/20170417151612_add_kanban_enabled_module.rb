class AddKanbanEnabledModule < ActiveRecord::Migration[5.0]
  def change
    EnabledModule.create(name: 'kanban/projects')
  end
end
