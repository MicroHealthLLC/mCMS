class AddSnomedToSocioeconomic < ActiveRecord::Migration[5.0]
  def change
    add_column :socioeconomics, :snomed, :string
  end
end
