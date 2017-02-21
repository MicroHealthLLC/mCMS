class CreateHcpcs < ActiveRecord::Migration[5.0]
  def change
    create_table :hcpcs do |t|
      t.string :hcpc
      t.text :long_description
      t.text :short_description

      t.timestamps
    end
  end
end
