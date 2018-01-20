class AddExpirationDateToDocument < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :expiration_date, :date
  end
end
