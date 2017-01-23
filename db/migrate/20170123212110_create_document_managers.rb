class CreateDocumentManagers < ActiveRecord::Migration[5.0]
  def change
    create_table :document_managers do |t|
      t.string   "title"
      t.text     "description"
      t.boolean  "is_private",  default: true
      t.boolean  "is_writable", default: false
      t.integer  "category_id"
      t.integer  "user_id"
      t.timestamps
    end
  end
end
