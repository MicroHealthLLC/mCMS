class CreateResumes < ActiveRecord::Migration[5.0]
  def change
    create_table :resumes do |t|
      t.integer :user_id
      t.string :title
      t.date :date
      t.integer :resume_type_id
      t.integer :resume_status_id
      t.text :note

      t.timestamps
    end
    add_index :resumes, :user_id
    EnabledModule.where(name: 'resumes').first_or_create
  end
end
