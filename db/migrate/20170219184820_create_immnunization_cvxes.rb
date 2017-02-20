class CreateImmnunizationCvxes < ActiveRecord::Migration[5.0]
  def change
    create_table :immunization_cvxes do |t|
      t.string :cvx_code
      t.text :cvx_short_description
      t.text :full_vaccine_name
      t.text :note
      t.string :vaccinestatus
      t.string :internal_id
      t.string :nonvaccine
      t.date :update_date

      t.timestamps
    end
  end
end
