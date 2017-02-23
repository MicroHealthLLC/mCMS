class AddNameToInjury < ActiveRecord::Migration[5.0]
  def change
    add_column :injuries, :injury_name, :string
    add_column :injuries, :injury_cause_name, :string
  end
end
