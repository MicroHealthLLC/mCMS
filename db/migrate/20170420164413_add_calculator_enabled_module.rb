class AddCalculatorEnabledModule < ActiveRecord::Migration[5.0]
  def change
    EnabledModule.create(name: 'calculator')
    EnabledModule.create(name: 'measurements_converter')
  end
end
