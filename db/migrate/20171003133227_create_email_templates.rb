class CreateEmailTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :email_templates do |t|
      t.text :header
      t.text :body
      t.text :footer
      t.string :model
      t.text :stylesheet

      t.timestamps
    end
  end
end
