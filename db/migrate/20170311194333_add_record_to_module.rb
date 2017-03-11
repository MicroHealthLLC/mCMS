class AddRecordToModule < ActiveRecord::Migration[5.0]
  def change
    modules = ['profile_record', 'occupational_record', 'medical_record', 'socioeconomic_record']
    modules.each do |m|
      EnabledModule.where(name: m).first_or_create
    end
  end
end
