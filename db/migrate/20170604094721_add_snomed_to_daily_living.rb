class AddSnomedToDailyLiving < ActiveRecord::Migration[5.0]
  def change
    add_column :daily_livings, :snomed, :string
    add_column :housings, :snomed, :string
    add_column :financials, :snomed, :string


  end
end
