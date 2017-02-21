class AddIsClientDocumentToDocument < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :is_client_document, :boolean, default: false
  end
end
