class AddUuidToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :uuid, :string
    User.all.each do |user|
      user.uuid = 10_000_000_000 + user.id
      user.save
    end
  end
end
