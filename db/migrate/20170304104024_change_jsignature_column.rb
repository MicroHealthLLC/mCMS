class ChangeJsignatureColumn < ActiveRecord::Migration[5.0]
  def self.up
    add_column :jsignatures, :signature_owner_type, :string
    add_column :jsignatures, :signature_owner_id, :integer
    add_index :jsignatures, :signature_owner_type
    add_index :jsignatures, :signature_owner_id

    Jsignature.all.each do |signature|
      if signature.appointment_id
        signature.signature_owner_type = "Appointment"
        signature.signature_owner_id = signature.appointment_id
      elsif signature.case_id
        signature.signature_owner_type = "Case"
        signature.signature_owner_id = signature.case_id
      end
      signature.save
    end

    remove_column :jsignatures, :case_id, :integer
    remove_column :jsignatures, :appointment_id, :integer
  end

  def self.down

  end
end
