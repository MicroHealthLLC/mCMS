class AddDatesToAffiliation < ActiveRecord::Migration[5.0]
  def change
    add_column :affiliations, :date_start, :date
    add_column :affiliations, :date_end, :date
  end
end
