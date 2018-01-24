class AddDateToLanguage < ActiveRecord::Migration[5.0]
  def change
    add_column :languages, :date, :date
  end
end
