class AddCreatedByToModels < ActiveRecord::Migration[5.0]
  def change
    add_column :admissions , :created_by_id, :integer
    add_column :affiliations , :created_by_id, :integer
    add_column :allergies , :created_by_id, :integer
    add_column :appointments , :created_by_id, :integer
    add_column :appointment_captures , :created_by_id, :integer
    add_column :appointment_dispositions , :created_by_id, :integer
    add_column :appointment_links , :created_by_id, :integer
    add_column :appointment_procedures , :created_by_id, :integer
    add_column :attachments , :created_by_id, :integer
    # add_column :awards , :created_by_id, :integer
    add_column :behavioral_risks , :created_by_id, :integer
    add_column :cases , :created_by_id, :integer
    add_column :case_relations , :created_by_id, :integer
    add_column :case_supports , :created_by_id, :integer
    add_column :case_watchers , :created_by_id, :integer
    add_column :categories , :created_by_id, :integer
    add_column :certifications , :created_by_id, :integer
    add_column :chat_rooms , :created_by_id, :integer
    add_column :checklists , :created_by_id, :integer
    add_column :checklist_answers , :created_by_id, :integer
    add_column :checklist_cases , :created_by_id, :integer
    add_column :checklist_templates , :created_by_id, :integer
    add_column :checklist_users , :created_by_id, :integer
    add_column :clearances , :created_by_id, :integer
    add_column :client_journals , :created_by_id, :integer
    add_column :client_organizations , :created_by_id, :integer
    add_column :contacts , :created_by_id, :integer
    add_column :core_demographics , :created_by_id, :integer
    add_column :daily_livings , :created_by_id, :integer
    add_column :departments , :created_by_id, :integer
    # add_column :deployment_histories , :created_by_id, :integer
    add_column :dms_documemnts , :created_by_id, :integer
    add_column :documents , :created_by_id, :integer
    add_column :document_managers , :created_by_id, :integer
    add_column :educations , :created_by_id, :integer
    add_column :enrollments , :created_by_id, :integer
    add_column :environment_risks , :created_by_id, :integer
    add_column :extend_demographies , :created_by_id, :integer
    add_column :family_histories , :created_by_id, :integer
    add_column :financials , :created_by_id, :integer
    add_column :goals , :created_by_id, :integer
    add_column :goal_plans , :created_by_id, :integer
    add_column :groups , :created_by_id, :integer
    add_column :health_care_facilities , :created_by_id, :integer
    add_column :housings , :created_by_id, :integer
    add_column :immunizations , :created_by_id, :integer
    # add_column :incident_histories , :created_by_id, :integer
    add_column :injuries , :created_by_id, :integer
    add_column :job_applications , :created_by_id, :integer
    add_column :job_details , :created_by_id, :integer
    add_column :jsignatures , :created_by_id, :integer
    add_column :languages , :created_by_id, :integer
    add_column :legals , :created_by_id, :integer
    add_column :medicals , :created_by_id, :integer
    add_column :medications , :created_by_id, :integer
    add_column :memberships , :created_by_id, :integer
    add_column :messages , :created_by_id, :integer
    # add_column :mtf_hospitals , :created_by_id, :integer
    add_column :needs , :created_by_id, :integer
    add_column :need_goals , :created_by_id, :integer
    add_column :news , :created_by_id, :integer
    add_column :notes , :created_by_id, :integer
    add_column :note_templates , :created_by_id, :integer
    add_column :organizations , :created_by_id, :integer
    add_column :other_histories , :created_by_id, :integer
    add_column :other_skills , :created_by_id, :integer
    add_column :place_of_services , :created_by_id, :integer
    add_column :plans , :created_by_id, :integer
    add_column :plan_tasks , :created_by_id, :integer
    add_column :positions , :created_by_id, :integer
    add_column :problem_lists , :created_by_id, :integer
    add_column :referrals , :created_by_id, :integer
    add_column :referral_relations , :created_by_id, :integer
    add_column :referral_results , :created_by_id, :integer
    add_column :roles , :created_by_id, :integer
    # add_column :service_histories , :created_by_id, :integer
    add_column :socioeconomics , :created_by_id, :integer
    add_column :surgicals , :created_by_id, :integer
    add_column :survey_cases , :created_by_id, :integer
    add_column :survey_users , :created_by_id, :integer
    add_column :tasks , :created_by_id, :integer
    add_column :task_boards , :created_by_id, :integer
    add_column :teleconsults , :created_by_id, :integer
    add_column :transportations , :created_by_id, :integer
    # add_column :units , :created_by_id, :integer
    add_column :user_insurances , :created_by_id, :integer
    add_column :wiki_pages , :created_by_id, :integer

    add_column :worker_compensations , :created_by_id, :integer


  end
end
