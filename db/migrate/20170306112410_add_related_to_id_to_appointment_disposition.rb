class AddRelatedToIdToAppointmentDisposition < ActiveRecord::Migration[5.0]
  def change
    add_column :appointment_dispositions, :related_to_id, :integer
    vals = ['Employment', 'Auto Accident', 'Other Accident', 'None' ]
    vals.each do |v|
      DispositionRelatedTo.where(name: v, active: true).first_or_create
    end
  end
end
