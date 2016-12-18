class CreateInsurances < ActiveRecord::Migration[5.0]
  def change
    create_table :insurances do |t|
      t.string :name

      t.timestamps
    end

    add_column :extend_demographies, :insurance_id, :integer
  end
end
