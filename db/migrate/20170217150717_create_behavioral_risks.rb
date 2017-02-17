class CreateBehavioralRisks < ActiveRecord::Migration[5.0]
  def change
    create_table :behavioral_risks do |t|
      t.integer :user_id
      t.integer :icdcm_code_id
      t.date :date_started
      t.date :date_ended
      t.integer :behavioral_risk_status_id
      t.integer :behavioral_risk_type_id
      t.text :description

      t.timestamps
    end
    add_index :behavioral_risks, :user_id

    modules = ['allergies', 'medicals' ,'surgicals' ,
               'problem_lists' ,'medications' ,'family_histories',
               'environment_risks', 'behavioral_risks',
               'immunizations', 'other_histories', 'socioeconomics']
    modules.each do |em|
      EnabledModule.where(name: em).first_or_create
    end
  end
end
