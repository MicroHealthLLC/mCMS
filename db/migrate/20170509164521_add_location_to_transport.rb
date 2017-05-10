class AddLocationToTransport < ActiveRecord::Migration[5.0]
  def change
    add_column :transports, :location, :string
  end
end
