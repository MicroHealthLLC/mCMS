class CreateLegals < ActiveRecord::Migration[5.0]
  def change
    create_table :legals do |t|
      t.integer :user_id
      t.string :title
      t.integer :legal_history_type_id
      t.integer :legal_history_status_id
      t.text :description
      t.date :date_start
      t.date :date_end

      t.timestamps
    end
    add_index :legals, :user_id

    modules = ['legals', 'transportations', 'financials']
    modules.each do |em|
      EnabledModule.where(name: em).first_or_create
    end
  end
end
