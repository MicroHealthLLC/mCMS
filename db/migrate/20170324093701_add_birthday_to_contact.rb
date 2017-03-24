class AddBirthdayToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :birthday, :date
    add_column :contacts, :gender_id, :integer
  end
end
