class AddInsuranceRelationshipIdToUserInsurance < ActiveRecord::Migration[5.0]
  def change
    add_column :user_insurances, :insurance_relationship_id, :integer
    add_column :user_insurances, :insured_name, :string
    vals = ['Self', 'Spouse', 'Child', 'Other']
    vals.each do |v|
      InsuranceRelationship.where(name: v, active: true).first_or_create
    end
  end
end
