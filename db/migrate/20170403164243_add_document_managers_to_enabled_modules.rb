class AddDocumentManagersToEnabledModules < ActiveRecord::Migration[5.0]
  def change
    EnabledModule.create(name: 'document_managers')
  end
end
