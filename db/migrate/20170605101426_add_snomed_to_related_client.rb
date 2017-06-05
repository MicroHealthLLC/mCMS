class AddSnomedToRelatedClient < ActiveRecord::Migration[5.0]
  def change
    add_column :related_clients, :snomed, :string
    RelatedClient.all.each do |rc|
      rc.update({snomed: rc.relationship})
    end
  end
end
