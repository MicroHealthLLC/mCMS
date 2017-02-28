class AddUserIdToAttachment < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :user_id, :integer
    add_index :attachments, :user_id

    Attachment.all.each do |attachment|
      attachment.user_id = attachment.owner.try(:user_id)
      attachment.save
    end
  end
end
