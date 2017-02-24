class AddNameToCertification < ActiveRecord::Migration[5.0]
  def change
    add_column :certifications, :name, :string
  end
end
