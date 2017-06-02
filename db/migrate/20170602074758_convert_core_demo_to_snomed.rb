class ConvertCoreDemoToSnomed < ActiveRecord::Migration[5.0]
  def self.up
    add_column :core_demographics, :ethnicity, :string
    add_column :core_demographics, :religion, :string

    CoreDemographic.all.each do |core_demographic|
      core_demographic.religion = core_demographic.religion_type.to_s
      core_demographic.ethnicity = core_demographic.ethnicity_type.to_s
      core_demographic.save
    end
  end

  def self.down
    remove_column :core_demographics, :ethnicity, :string
    remove_column :core_demographics, :religion, :string
  end
end
