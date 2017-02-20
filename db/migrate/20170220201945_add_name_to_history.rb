class AddNameToHistory < ActiveRecord::Migration[5.0]
  def change
    add_column :other_histories, :name, :string
    add_column :environment_risks, :name, :string
    add_column :socioeconomics, :name, :string
    add_column :family_histories, :name, :string
    add_column :behavioral_risks, :name, :string
    add_column :medicals, :name, :string
    add_column :surgicals, :name, :string
    add_column :problem_lists, :name, :string
  end
end
