class Dmsf < ActiveRecord::Migration[5.0]
  def change
    create_table "categories" do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "name"
      t.text     "description"
      t.boolean  "is_private",  default: false
      t.boolean  "is_writable", default: false
      t.integer  "parent_id"
      t.integer  "group_id"
      t.boolean  "is_featured", default: false
    end

    create_table "groups" do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "name"
    end

    create_table "memberships" do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "group_id"
      t.integer  "user_id"
      t.integer  "level"
    end

    create_table "revisions" do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "document_manager_id"
      t.integer  "user_id"
      t.integer  "position"
      t.integer  "download_count",                 default: 0
      t.string   "file_name"
      t.string   "file_type"
      t.integer  "file_size"
      t.binary   "file_data",      limit: 4194304
      t.text     "search_text"
    end

  end
end
