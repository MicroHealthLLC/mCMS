class AddUpdatedByToModels < ActiveRecord::Migration[5.0]
  def change
    add_column :admissions , :updated_by_id, :integer
    add_column :affiliations , :updated_by_id, :integer
    add_column :allergies , :updated_by_id, :integer
    add_column :appointments , :updated_by_id, :integer
    add_column :appointment_captures , :updated_by_id, :integer
    add_column :appointment_dispositions , :updated_by_id, :integer
    add_column :appointment_links , :updated_by_id, :integer
    add_column :appointment_procedures , :updated_by_id, :integer
    add_column :attachments , :updated_by_id, :integer
    # add_column :awards , :updated_by_id, :integer
    add_column :behavioral_risks , :updated_by_id, :integer
    add_column :cases , :updated_by_id, :integer
    add_column :case_relations , :updated_by_id, :integer
    add_column :case_supports , :updated_by_id, :integer
    add_column :case_watchers , :updated_by_id, :integer
    add_column :categories , :updated_by_id, :integer
    add_column :certifications , :updated_by_id, :integer
    add_column :chat_rooms , :updated_by_id, :integer
    add_column :checklists , :updated_by_id, :integer
    add_column :checklist_answers , :updated_by_id, :integer
    add_column :checklist_cases , :updated_by_id, :integer
    add_column :checklist_templates , :updated_by_id, :integer
    add_column :checklist_users , :updated_by_id, :integer
    add_column :clearances , :updated_by_id, :integer
    add_column :client_journals , :updated_by_id, :integer
    add_column :client_organizations , :updated_by_id, :integer
    add_column :contacts , :updated_by_id, :integer
    add_column :core_demographics , :updated_by_id, :integer
    add_column :daily_livings , :updated_by_id, :integer
    add_column :departments , :updated_by_id, :integer
    # add_column :deployment_histories , :updated_by_id, :integer
    add_column :dms_documemnts , :updated_by_id, :integer
    add_column :documents , :updated_by_id, :integer
    add_column :document_managers , :updated_by_id, :integer
    add_column :educations , :updated_by_id, :integer
    add_column :enrollments , :updated_by_id, :integer
    add_column :environment_risks , :updated_by_id, :integer
    add_column :extend_demographies , :updated_by_id, :integer
    add_column :family_histories , :updated_by_id, :integer
    add_column :financials , :updated_by_id, :integer
    add_column :goals , :updated_by_id, :integer
    add_column :goal_plans , :updated_by_id, :integer
    add_column :groups , :updated_by_id, :integer
    add_column :health_care_facilities , :updated_by_id, :integer
    add_column :housings , :updated_by_id, :integer
    add_column :immunizations , :updated_by_id, :integer
    # add_column :incident_histories , :updated_by_id, :integer
    add_column :injuries , :updated_by_id, :integer
    add_column :job_applications , :updated_by_id, :integer
    add_column :job_details , :updated_by_id, :integer
    add_column :jsignatures , :updated_by_id, :integer
    add_column :languages , :updated_by_id, :integer
    add_column :legals , :updated_by_id, :integer
    add_column :medicals , :updated_by_id, :integer
    add_column :medications , :updated_by_id, :integer
    add_column :memberships , :updated_by_id, :integer
    add_column :messages , :updated_by_id, :integer
    # add_column :mtf_hospitals , :updated_by_id, :integer
    add_column :needs , :updated_by_id, :integer
    add_column :need_goals , :updated_by_id, :integer
    add_column :news , :updated_by_id, :integer
    add_column :notes , :updated_by_id, :integer
    add_column :note_templates , :updated_by_id, :integer
    add_column :organizations , :updated_by_id, :integer
    add_column :other_histories , :updated_by_id, :integer
    add_column :other_skills , :updated_by_id, :integer
    add_column :place_of_services , :updated_by_id, :integer
    add_column :plans , :updated_by_id, :integer
    add_column :plan_tasks , :updated_by_id, :integer
    add_column :positions , :updated_by_id, :integer
    add_column :problem_lists , :updated_by_id, :integer
    add_column :referrals , :updated_by_id, :integer
    add_column :referral_relations , :updated_by_id, :integer
    add_column :referral_results , :updated_by_id, :integer
    add_column :roles , :updated_by_id, :integer
    # add_column :service_histories , :updated_by_id, :integer
    add_column :socioeconomics , :updated_by_id, :integer
    add_column :surgicals , :updated_by_id, :integer
    add_column :survey_cases , :updated_by_id, :integer
    add_column :survey_users , :updated_by_id, :integer
    add_column :tasks , :updated_by_id, :integer
    add_column :task_boards , :updated_by_id, :integer
    add_column :teleconsults , :updated_by_id, :integer
    add_column :transportations , :updated_by_id, :integer
    # add_column :units , :updated_by_id, :integer
    add_column :user_insurances , :updated_by_id, :integer
    add_column :wiki_pages , :updated_by_id, :integer

    add_column :worker_compensations , :updated_by_id, :integer


  end
end
