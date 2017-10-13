class CreateMhspreadsheetMhSpreadsheets < ActiveRecord::Migration[5.0]
  def change
    create_table :mhspreadsheet_mh_spreadsheets do |t|
      t.integer :user_id
      t.text :content

      t.timestamps
    end
    add_index :mhspreadsheet_mh_spreadsheets, :user_id

    modules = ['mh_spreadsheets']
    modules.each do |em|
      EnabledModule.where(name: em).first_or_create
    end
  end
end
