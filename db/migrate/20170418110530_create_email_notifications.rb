class CreateEmailNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :email_notifications do |t|
      t.string :name
      t.string :email_type
      t.boolean :status

      t.timestamps
    end
  end
end
