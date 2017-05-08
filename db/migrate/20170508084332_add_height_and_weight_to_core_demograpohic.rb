class AddHeightAndWeightToCoreDemograpohic < ActiveRecord::Migration[5.0]
  def change
    add_column :core_demographics, :height, :float
    add_column :core_demographics, :weight, :float
  end
end
