class RemoveModules < ActiveRecord::Migration[5.0]
  def change
    m= ['mtf_hospitals', 'incident_histories', 'deployment_histories', 'awards',
        'units', 'service_histories']
    EnabledModule.where(name: m).delete_all
  end
end
