class CreateUserInsurances < ActiveRecord::Migration[5.0]
  def change
    create_table :user_insurances do |t|
      t.integer :user_id
      t.integer :insurance_id
      t.integer :insurance_type_id
      t.string :insurance_identifier
      t.text :note

      t.timestamps
    end

    modules = %w{insurances}
    modules.each do |em|
      EnabledModule.create(name: em)
    end
  end
end
