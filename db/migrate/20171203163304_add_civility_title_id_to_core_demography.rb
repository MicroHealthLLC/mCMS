class AddCivilityTitleIdToCoreDemography < ActiveRecord::Migration[5.0]
  def change
    add_column :core_demographics, :civility_title_id, :integer
  end
end
