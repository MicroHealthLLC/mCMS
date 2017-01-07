class AddMissingColumnsToCaseSupport < ActiveRecord::Migration[5.0]
  def change
    add_column :case_supports, :support_status_id, :integer
    add_column :case_supports, :date_started, :date
    add_column :case_supports, :date_ended, :date

    add_column :contacts, :date_ended, :date
    add_column :contacts, :date_started, :date
    add_column :contacts, :contact_status_id, :integer

    add_column :user_insurances, :issue_date, :date
    add_column :user_insurances, :expiration_date, :date

  end
end
