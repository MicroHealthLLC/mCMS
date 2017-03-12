class CreateLaboratoryExaminations < ActiveRecord::Migration[5.0]
  def change
    create_table :laboratory_examinations do |t|
      t.integer :user_id
      t.string :name
      t.string :facility
      t.date :date
      t.text :result
      t.integer :laboratory_result_status_id

      t.timestamps
    end
    add_index :laboratory_examinations, :user_id

    modules = ['laboratory_examinations', 'radiologic_examinations']
    modules.each do |m|
      EnabledModule.where(name: m).first_or_create
    end
  end
end
