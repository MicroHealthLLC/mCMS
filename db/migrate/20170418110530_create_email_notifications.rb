class CreateEmailNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :email_notifications do |t|
      t.string :name
      t.string :email_type
      t.boolean :status, default: true

      t.timestamps
    end
    add_index :email_notifications, :name
    add_index :email_notifications, :email_type

    emails_type = ["Admission", "Affiliation", "Allergy", "Appointment",
                   "BehavioralRisk", "Case", "CaseSupport", "Certification",
                   "Clearance", "ClientJournal", "Contact", "DailyLiving", "Document",
                   "Education", "Enrollment", "EnvironmentRisk", "FamilyHistory", "Financial",
                   "Goal", "HealthCareFacility", "Housing", "Immunization", "Injury",
                   "JobApplication", "LaboratoryExamination", "Language", "Legal", "Medical",
                   "Medication", "MilitaryHistory", "Need", "OtherHistory", "OtherSkill", "Plan",
                   "Position", "ProblemList", "RadiologicExamination", "Referral",
                   "Socioeconomic", "Surgical", "Task", "Teleconsult", "Transportation",
                   "UserInsurance", "WorkerCompensation"]

    emails_type.each do |e|
      EmailNotification.create(name: e, email_type: 'create')
      EmailNotification.create(name: e, email_type: 'update')
    end
  end
end
