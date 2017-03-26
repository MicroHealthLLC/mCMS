class AddRorDit < ActiveRecord::Migration[5.0]
  def change
    EnabledModule.where(name: 'rordit/links').first_or_create
  end
end
