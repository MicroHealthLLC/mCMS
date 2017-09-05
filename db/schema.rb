# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170814141339) do

  create_table "addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "address_type_id"
    t.string   "address"
    t.string   "city"
    t.string   "zip_code"
    t.string   "state"
    t.string   "country_code"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "extend_demography_id"
    t.integer  "country_id"
    t.integer  "state_id"
    t.string   "second_address"
    t.float    "location_lat",         limit: 24
    t.float    "location_long",        limit: 24
  end

  create_table "admissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "care_family_name"
    t.string   "date_admitted"
    t.string   "date_discharged"
    t.integer  "admission_status_id"
    t.integer  "admission_type_id"
    t.text     "description",         limit: 16777215
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.float    "location_lat",        limit: 24
    t.float    "location_long",       limit: 24
    t.index ["user_id"], name: "index_admissions_on_user_id", using: :btree
  end

  create_table "affiliations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "affiliation_type_id"
    t.text     "note",                limit: 16777215
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "status_id"
    t.date     "date_start"
    t.date     "date_end"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "allergies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "allergy_type_id"
    t.string   "medication"
    t.date     "allergy_date"
    t.integer  "allergy_status_id"
    t.text     "description",       limit: 16777215
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.string   "snomed"
    t.index ["user_id"], name: "index_allergies_on_user_id", using: :btree
  end

  create_table "appointment_captures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "appointment_id"
    t.integer  "assessment_id"
    t.text     "note",           limit: 16777215
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.date     "date_recorded"
    t.integer  "icdcm_code_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "appointment_dispositions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "appointment_id"
    t.integer  "disposition_id"
    t.text     "note",           limit: 16777215
    t.date     "date_recorded"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "related_to_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "appointment_links", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "appointment_id"
    t.string   "linkable_type"
    t.integer  "linkable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["appointment_id"], name: "index_appointment_links_on_appointment_id", using: :btree
    t.index ["linkable_id"], name: "index_appointment_links_on_linkable_id", using: :btree
    t.index ["linkable_type"], name: "index_appointment_links_on_linkable_type", using: :btree
    t.index ["user_id"], name: "index_appointment_links_on_user_id", using: :btree
  end

  create_table "appointment_procedures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "appointment_id"
    t.integer  "procedure_id"
    t.text     "note",              limit: 16777215
    t.date     "date_recorded"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "hcpc_id"
    t.string   "modifier"
    t.integer  "em_code_id"
    t.string   "unit"
    t.string   "diagnosis_pointer"
    t.integer  "epsdt_id"
    t.integer  "emergency_id"
    t.string   "charges"
    t.integer  "provider_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["provider_id"], name: "index_appointment_procedures_on_provider_id", using: :btree
  end

  create_table "appointments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description",           limit: 16777215
    t.integer  "appointment_type_id"
    t.datetime "date"
    t.string   "time"
    t.integer  "appointment_status_id"
    t.integer  "user_id"
    t.integer  "with_who_id"
    t.string   "with_who_type"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "related_to_id"
    t.datetime "end_time"
    t.integer  "place_of_service_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["place_of_service_id"], name: "index_appointments_on_place_of_service_id", using: :btree
  end

  create_table "attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.string   "file"
    t.string   "description"
    t.integer  "owner_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_attachments_on_user_id", using: :btree
  end

  create_table "audits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes", limit: 65535
    t.integer  "version",                       default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index", using: :btree
    t.index ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
    t.index ["created_at"], name: "index_audits_on_created_at", using: :btree
    t.index ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
    t.index ["user_id", "user_type"], name: "user_index", using: :btree
  end

  create_table "awards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "award_type_id"
    t.integer  "award_enum_id"
    t.date     "award_date"
    t.text     "note",          limit: 16777215
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_awards_on_user_id", using: :btree
  end

  create_table "behavioral_risks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "icdcm_code_id"
    t.date     "date_started"
    t.date     "date_ended"
    t.integer  "behavioral_risk_status_id"
    t.integer  "behavioral_risk_type_id"
    t.text     "description",               limit: 16777215
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "name"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.string   "snomed"
    t.index ["user_id"], name: "index_behavioral_risks_on_user_id", using: :btree
  end

  create_table "billings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "appointment_id"
    t.integer  "bill_type_id"
    t.integer  "bill_status_id"
    t.date     "bill_date"
    t.integer  "bill_amount"
    t.integer  "accept_assignment_id"
    t.text     "resubmission_code",          limit: 16777215
    t.text     "original_reference_number",  limit: 16777215
    t.text     "prior_authorization_number", limit: 16777215
    t.integer  "outside_lab_id"
    t.float    "outside_lab_charges",        limit: 24
    t.integer  "other_source_id"
    t.float    "total_charge",               limit: 24
    t.float    "amount_paid",                limit: 24
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.text     "note",                       limit: 16777215
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.float    "amount_collected",           limit: 24
    t.string   "associated_icd"
    t.string   "associated_hcpc"
    t.index ["appointment_id"], name: "index_billings_on_appointment_id", using: :btree
    t.index ["user_id"], name: "index_billings_on_user_id", using: :btree
  end

  create_table "blorgh_articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "text",       limit: 16777215
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "case_organizations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "case_id"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "association_id"
    t.integer  "user_id"
    t.index ["case_id"], name: "index_case_organizations_on_case_id", using: :btree
    t.index ["organization_id"], name: "index_case_organizations_on_organization_id", using: :btree
    t.index ["user_id"], name: "index_case_organizations_on_user_id", using: :btree
  end

  create_table "case_relations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "case_id"
    t.string   "relation_type"
    t.integer  "relation_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "case_supports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "case_id"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.integer  "case_support_type_id"
    t.text     "note",                 limit: 16777215
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.boolean  "not_show_in_search",                    default: false
    t.integer  "support_status_id"
    t.date     "date_started"
    t.date     "date_ended"
    t.boolean  "status",                                default: true
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "case_watchers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "case_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.text     "reason",        limit: 16777215
  end

  create_table "cases", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.integer  "priority_id"
    t.integer  "case_type_id"
    t.date     "date_start"
    t.date     "date_due"
    t.date     "date_completed"
    t.integer  "assigned_to_id"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "subcase_id"
    t.text     "note",                limit: 16777215
    t.integer  "case_status_type_id"
    t.integer  "case_category_id"
    t.text     "description",         limit: 16777215
    t.boolean  "is_private",                           default: false
    t.integer  "private_author_id"
    t.integer  "user_id"
    t.integer  "case_source_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description",   limit: 16777215
    t.boolean  "is_private",                     default: false
    t.boolean  "is_writable",                    default: false
    t.integer  "parent_id"
    t.integer  "group_id"
    t.boolean  "is_featured",                    default: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "certifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "certification_type_id"
    t.integer  "user_id"
    t.date     "date_received"
    t.text     "note",                    limit: 16777215
    t.date     "date_expired"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "file"
    t.integer  "status_id"
    t.string   "name"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.string   "certifying_organization"
    t.float    "location_lat",            limit: 24
    t.float    "location_long",           limit: 24
  end

  create_table "chat_rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "receiver_id"
    t.string   "token"
    t.boolean  "message_seen",  default: true
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_chat_rooms_on_user_id", using: :btree
  end

  create_table "checklist_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "status"
    t.integer  "user_id"
    t.integer  "checklist_id"
    t.integer  "checklist_template_id"
    t.date     "due_date"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "checklist_case_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "checklist_cases", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "assigned_to_id"
    t.integer  "checklist_template_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "checklist_status_type_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "checklist_templates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "checklist_type_id"
    t.integer  "user_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "title"
    t.text     "description",              limit: 16777215
    t.integer  "related_to_id"
    t.string   "related_to_type"
    t.integer  "checklist_status_type_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "checklist_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "assigned_to_id"
    t.integer  "checklist_template_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "checklists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "status"
    t.string   "description"
    t.date     "due_date"
    t.integer  "user_id"
    t.integer  "checklist_template_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "clearances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "clearence_type_id"
    t.integer  "user_id"
    t.date     "date_received"
    t.text     "note",              limit: 16777215
    t.date     "date_expired"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "file"
    t.integer  "status_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "client_journals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.integer  "client_journal_type_id"
    t.datetime "date"
    t.text     "note",                   limit: 16777215
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "user_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_client_journals_on_user_id", using: :btree
  end

  create_table "client_organizations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "organization_type_id"
    t.integer  "organization_id"
    t.text     "note",                 limit: 16777215
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "comment",      limit: 16777215
    t.integer  "points_count",                  default: 0
    t.string   "username"
    t.integer  "user_id"
    t.integer  "link_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["link_id"], name: "index_comments_on_link_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "emergency_contact"
    t.text     "note",               limit: 16777215
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "contact_type_id"
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "file"
    t.boolean  "not_show_in_search",                  default: false
    t.date     "date_ended"
    t.date     "date_started"
    t.integer  "contact_status_id"
    t.boolean  "status",                              default: true
    t.integer  "language_type_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.date     "birthday"
    t.integer  "gender_id"
    t.string   "language"
    t.string   "gender"
  end

  create_table "core_demographics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.integer  "gender_id"
    t.date     "birth_date"
    t.integer  "religion_id"
    t.string   "title"
    t.text     "note",                limit: 16777215
    t.integer  "ethnicity_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "citizenship_type_id"
    t.integer  "marital_status_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.float    "height",              limit: 24
    t.float    "weight",              limit: 24
    t.string   "ethnicity"
    t.string   "religion"
    t.string   "gender"
  end

  create_table "daily_livings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "daily_living_type_id"
    t.integer  "daily_living_status_id"
    t.text     "description",            limit: 16777215
    t.date     "date_start"
    t.date     "date_end"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.string   "snomed"
    t.index ["user_id"], name: "index_daily_livings_on_user_id", using: :btree
  end

  create_table "departments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.text     "note",               limit: 16777215
    t.date     "date_start"
    t.date     "date_end"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "department_type_id"
    t.integer  "organization_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "deployment_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "deployment_operation_id"
    t.string   "location"
    t.string   "city"
    t.integer  "state_id"
    t.integer  "country_id"
    t.date     "date_start"
    t.date     "date_end"
    t.text     "note",                    limit: 16777215
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_deployment_histories_on_user_id", using: :btree
  end

  create_table "dms_documemnts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "document_manager_id"
    t.string   "doc"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.integer  "revision_id"
  end

  create_table "document_folders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "document_managers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description",   limit: 16777215
    t.boolean  "is_private",                     default: true
    t.boolean  "is_writable",                    default: false
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.integer  "folder_id"
    t.index ["folder_id"], name: "index_document_managers_on_folder_id", using: :btree
  end

  create_table "documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description",        limit: 16777215
    t.integer  "user_id"
    t.integer  "document_type_id"
    t.date     "date"
    t.string   "attachment"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "related_to_id"
    t.string   "related_to_type"
    t.boolean  "is_private",                          default: false
    t.integer  "private_author_id"
    t.boolean  "is_client_document",                  default: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.string   "snomed"
  end

  create_table "educations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "education_type"
    t.string   "other_skill"
    t.date     "date_recieved"
    t.date     "date_expired"
    t.text     "note",                  limit: 16777215
    t.integer  "clearence"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "user_id"
    t.integer  "education_type_id"
    t.integer  "certification_type_id"
    t.string   "file"
    t.integer  "status_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.string   "institution"
    t.float    "location_lat",          limit: 24
    t.float    "location_long",         limit: 24
  end

  create_table "email_notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email_type"
    t.boolean  "status",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["email_type"], name: "index_email_notifications_on_email_type", using: :btree
    t.index ["name"], name: "index_email_notifications_on_name", using: :btree
  end

  create_table "emails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email_address"
    t.integer  "email_type_id"
    t.integer  "extend_demography_id"
    t.text     "note",                 limit: 16777215
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "enabled_modules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.boolean  "status",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "enrollments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "enrollment_type_id"
    t.integer  "enrollment_status_id"
    t.date     "date_start"
    t.date     "date_end"
    t.text     "note",                 limit: 16777215
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "case_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "enumerations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",          limit: 30, default: "",    null: false
    t.integer "position"
    t.boolean "is_default",               default: false, null: false
    t.string  "type"
    t.boolean "active",                   default: true,  null: false
    t.string  "position_name", limit: 30
    t.boolean "is_flagged",               default: false
    t.boolean "is_closed",                default: false
  end

  create_table "environment_risks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "icdcm_code_id"
    t.date     "date_started"
    t.date     "date_ended"
    t.integer  "environment_status_id"
    t.integer  "environment_type_id"
    t.text     "description",           limit: 16777215
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.string   "snomed"
    t.index ["user_id"], name: "index_environment_risks_on_user_id", using: :btree
  end

  create_table "ethnicities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ethnicity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_calendar_events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "exception_notifiers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "extend_demographies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "type"
    t.integer  "department_id"
    t.integer  "contact_id"
    t.integer  "organization_id"
    t.integer  "affiliation_id"
    t.integer  "insurance_id"
    t.integer  "case_support_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_extend_demographies_on_user_id", using: :btree
  end

  create_table "family_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "icdcm_code_id"
    t.date     "date_identified"
    t.integer  "family_status_id"
    t.integer  "family_type_id"
    t.text     "description",      limit: 16777215
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "name"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.string   "snomed"
    t.index ["user_id"], name: "index_family_histories_on_user_id", using: :btree
  end

  create_table "faxes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "fax_number"
    t.integer  "fax_type_id"
    t.integer  "extend_demography_id"
    t.text     "note",                 limit: 16777215
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "financials", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "financial_type_id"
    t.integer  "financial_status_id"
    t.integer  "financial_state_id"
    t.text     "description",         limit: 16777215
    t.string   "estimated_amount"
    t.date     "date_start"
    t.date     "date_end"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.string   "snomed"
    t.index ["user_id"], name: "index_financials_on_user_id", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "slug",           limit: 191, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 191
    t.datetime "created_at",                 null: false
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "genders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goal_plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "plan_id"
    t.integer  "goal_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "goals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "priority_type_id"
    t.integer  "goal_status_id"
    t.text     "description",      limit: 16777215
    t.date     "date_start"
    t.date     "date_due"
    t.date     "date_completed"
    t.integer  "user_id"
    t.integer  "case_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "assigned_to_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.integer  "percent_done"
    t.integer  "goal_type_id"
    t.index ["assigned_to_id"], name: "index_goals_on_assigned_to_id", using: :btree
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "hcpcs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "hcpc"
    t.text     "long_description",  limit: 16777215
    t.text     "short_description", limit: 16777215
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "health_care_facilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "health_care_facility_type_id"
    t.integer  "health_care_facility_status_id"
    t.text     "health_care_facility_contact",   limit: 16777215
    t.date     "date_started"
    t.date     "date_end"
    t.text     "description",                    limit: 16777215
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.float    "location_lat",                   limit: 24
    t.float    "location_long",                  limit: 24
    t.index ["user_id"], name: "index_health_care_facilities_on_user_id", using: :btree
  end

  create_table "housings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "housing_type_id"
    t.integer  "cohabitation_type_id"
    t.integer  "housing_status_id"
    t.text     "description",               limit: 16777215
    t.integer  "primary_address_id"
    t.string   "estimated_monthly_payment"
    t.date     "date_start"
    t.date     "date_end"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.string   "snomed"
    t.index ["user_id"], name: "index_housings_on_user_id", using: :btree
  end

  create_table "icd10data", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.text     "description", limit: 16777215
    t.text     "childrens",   limit: 16777215
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["name"], name: "index_icd10data_on_name", using: :btree
    t.index ["parent_id"], name: "index_icd10data_on_parent_id", using: :btree
  end

  create_table "identifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "identification_number"
    t.boolean  "status"
    t.date     "date_expired"
    t.string   "date_issued"
    t.text     "note",                   limit: 16777215
    t.integer  "identification_type_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "extend_demography_id"
    t.integer  "issued_by_type_id"
  end

  create_table "immunization_cvxes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "cvx_code"
    t.text     "cvx_short_description", limit: 16777215
    t.text     "full_vaccine_name",     limit: 16777215
    t.text     "note",                  limit: 16777215
    t.string   "vaccinestatus"
    t.string   "internal_id"
    t.string   "nonvaccine"
    t.date     "update_date"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "immunizations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "medication"
    t.integer  "total_number_of_doses"
    t.integer  "doses_given"
    t.date     "next_date_due"
    t.date     "date_immunized"
    t.text     "manufacturer",           limit: 16777215
    t.text     "lot_number",             limit: 16777215
    t.date     "expiration_date"
    t.integer  "immunization_status_id"
    t.text     "description",            limit: 16777215
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "immunization_cvx_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.string   "snomed"
    t.index ["user_id"], name: "index_immunizations_on_user_id", using: :btree
  end

  create_table "incident_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "incident"
    t.integer  "incident_type_id"
    t.integer  "incident_category_id"
    t.date     "date_of_incident"
    t.date     "date_diagnosed"
    t.string   "incident_location_address"
    t.string   "incident_location_city"
    t.integer  "state_id"
    t.integer  "country_id"
    t.integer  "operation_id"
    t.integer  "verified_personnel_casualty_reporting_system_id"
    t.integer  "line_of_duty_investigation_id"
    t.string   "cause_of_injury"
    t.text     "injury_description",                              limit: 16777215
    t.string   "pending_operation_procedure"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_incident_histories_on_user_id", using: :btree
  end

  create_table "injuries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "icdcm_code_id"
    t.integer  "injury_type_id"
    t.integer  "injury_cause_id"
    t.integer  "injury_status_id"
    t.string   "employer"
    t.date     "date_of_injury"
    t.date     "date_resolved"
    t.text     "description",       limit: 16777215
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "injury_name"
    t.string   "injury_cause_name"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.string   "snomed_occupation"
    t.string   "snomed_event"
    t.index ["user_id"], name: "index_injuries_on_user_id", using: :btree
  end

  create_table "insurances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventory_product_assigns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.date     "date"
    t.integer  "assignment_status_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["product_id"], name: "index_inventory_product_assigns_on_product_id", using: :btree
    t.index ["user_id"], name: "index_inventory_product_assigns_on_user_id", using: :btree
  end

  create_table "inventory_products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description",         limit: 65535
    t.integer  "product_category_id"
    t.integer  "product_type_id"
    t.string   "manufacturer"
    t.string   "model"
    t.string   "serial"
    t.float    "unit_cost",           limit: 24
    t.integer  "product_location_id"
    t.integer  "product_status_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "job_applications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "employer"
    t.string   "position_applied"
    t.string   "projected_salary"
    t.integer  "application_type_id"
    t.date     "application_date"
    t.integer  "application_status_id"
    t.integer  "interview_type_id"
    t.date     "interview_date"
    t.integer  "interview_status_id"
    t.integer  "selection_status_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.float    "location_lat",          limit: 24
    t.float    "location_long",         limit: 24
    t.index ["user_id"], name: "index_job_applications_on_user_id", using: :btree
  end

  create_table "job_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.text     "note",            limit: 16777215
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "organization_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["role_id"], name: "index_job_details_on_role_id", using: :btree
    t.index ["user_id"], name: "index_job_details_on_user_id", using: :btree
  end

  create_table "journal_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.text     "answer",     limit: 16777215
    t.integer  "journal_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "journals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "journal_type_id"
    t.text     "question",        limit: 16777215
    t.integer  "user_id"
    t.integer  "assigned_to_id"
    t.date     "due_date"
    t.date     "date_completed"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "jsignatures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "person_name"
    t.text     "signature",            limit: 16777215
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "signature_owner_type"
    t.integer  "signature_owner_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["signature_owner_id"], name: "index_jsignatures_on_signature_owner_id", using: :btree
    t.index ["signature_owner_type"], name: "index_jsignatures_on_signature_owner_type", using: :btree
    t.index ["user_id"], name: "index_jsignatures_on_user_id", using: :btree
  end

  create_table "kanban_cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description",    limit: 65535
    t.string   "color"
    t.integer  "created_by_id"
    t.date     "start_date"
    t.date     "due_date"
    t.date     "date_completed"
    t.integer  "column_id"
    t.integer  "project_id"
    t.boolean  "is_archived",                  default: false
    t.datetime "archived_on"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["column_id"], name: "index_kanban_cards_on_column_id", using: :btree
  end

  create_table "kanban_changesets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "story_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_kanban_changesets_on_project_id", using: :btree
    t.index ["story_id"], name: "index_kanban_changesets_on_story_id", using: :btree
  end

  create_table "kanban_columns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "project_id"
    t.integer  "position"
    t.text     "settings",   limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["project_id"], name: "index_kanban_columns_on_project_id", using: :btree
  end

  create_table "kanban_notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "note",       limit: 16777215
    t.integer  "user_id"
    t.integer  "story_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "kanban_project_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_kanban_project_users_on_project_id", using: :btree
    t.index ["user_id"], name: "index_kanban_project_users_on_user_id", using: :btree
  end

  create_table "kanban_projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "point_scale",         default: "fibonacci"
    t.date     "start_date"
    t.integer  "iteration_start_day", default: 1
    t.integer  "iteration_length",    default: 1
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "default_velocity",    default: 10
  end

  create_table "kanban_stories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description",     limit: 16777215
    t.integer  "estimate"
    t.string   "story_type",                                      default: "feature"
    t.string   "state",                                           default: "unstarted"
    t.date     "accepted_at"
    t.integer  "requested_by_id"
    t.integer  "owned_by_id"
    t.integer  "project_id"
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.decimal  "position",                         precision: 10
    t.string   "labels"
    t.index ["project_id"], name: "index_kanban_stories_on_project_id", using: :btree
  end

  create_table "laboratory_examinations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "facility"
    t.date     "date"
    t.text     "result",                      limit: 16777215
    t.integer  "laboratory_result_status_id"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "snomed"
    t.index ["user_id"], name: "index_laboratory_examinations_on_user_id", using: :btree
  end

  create_table "languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "language_type_id"
    t.integer  "proficiency_id"
    t.text     "note",             limit: 16777215
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "status_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.string   "snomed"
  end

  create_table "legals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "legal_history_type_id"
    t.integer  "legal_history_status_id"
    t.text     "description",             limit: 16777215
    t.date     "date_start"
    t.date     "date_end"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_legals_on_user_id", using: :btree
  end

  create_table "links", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "url"
    t.string   "hostname"
    t.float    "popularity",     limit: 24, default: 0.0
    t.integer  "comments_count",            default: 0
    t.integer  "points_count",              default: 0
    t.string   "username"
    t.integer  "user_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["user_id"], name: "index_links_on_user_id", using: :btree
  end

  create_table "links_links", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "url"
    t.string   "hostname"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_links_links_on_user_id", using: :btree
  end

  create_table "lms_assignments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "body",       limit: 65535
    t.integer  "course_id"
    t.integer  "teacher_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "due_date"
    t.string   "category"
  end

  create_table "lms_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",    limit: 65535
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["lesson_id"], name: "index_lms_comments_on_lesson_id", using: :btree
    t.index ["user_id"], name: "index_lms_comments_on_user_id", using: :btree
  end

  create_table "lms_course_links", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "course_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lms_courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.string   "course_code"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "teacher_id"
    t.index ["teacher_id"], name: "index_lms_courses_on_teacher_id", using: :btree
  end

  create_table "lms_enrollments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "course_id"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_lms_enrollments_on_course_id", using: :btree
    t.index ["student_id"], name: "index_lms_enrollments_on_student_id", using: :btree
  end

  create_table "lms_lessons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "title"
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["course_id"], name: "index_lms_lessons_on_course_id", using: :btree
    t.index ["user_id"], name: "index_lms_lessons_on_user_id", using: :btree
  end

  create_table "lms_student_assignments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "assignment_id"
    t.integer  "student_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "completed"
  end

  create_table "measurement_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "measurement"
    t.integer  "component_id"
    t.string   "measured_by"
    t.datetime "date_time"
    t.integer  "recorded_by_id"
    t.integer  "user_id"
    t.string   "device_id"
    t.integer  "age"
    t.float    "height",                limit: 24
    t.float    "weight",                limit: 24
    t.integer  "gender_id"
    t.integer  "measure"
    t.string   "flag"
    t.integer  "measurement_status_id"
    t.integer  "case_id"
    t.integer  "plan_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "gender"
    t.index ["case_id"], name: "index_measurement_records_on_case_id", using: :btree
    t.index ["plan_id"], name: "index_measurement_records_on_plan_id", using: :btree
    t.index ["user_id"], name: "index_measurement_records_on_user_id", using: :btree
  end

  create_table "measurements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "component"
    t.string   "order"
    t.integer  "lower_age",                      default: 0
    t.integer  "upper_age",                      default: 0
    t.float    "lower_height",        limit: 24, default: 0.0
    t.float    "upper_height",        limit: 24, default: 0.0
    t.float    "lower_weight",        limit: 24, default: 0.0
    t.float    "upper_weight",        limit: 24, default: 0.0
    t.integer  "gender_id"
    t.integer  "measured_by_id"
    t.integer  "lower_measure",                  default: 0
    t.integer  "higher_measure",                 default: 0
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "measurement_name_id"
    t.string   "gender"
  end

  create_table "medicals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "icdcm_code_id"
    t.string   "medical_facility"
    t.date     "date_of_diagnosis"
    t.integer  "medical_history_status_id"
    t.integer  "medical_history_type_id"
    t.text     "description",               limit: 16777215
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "name"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.string   "snomed"
    t.float    "location_lat",              limit: 24
    t.float    "location_long",             limit: 24
    t.index ["user_id"], name: "index_medicals_on_user_id", using: :btree
  end

  create_table "medications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "medication"
    t.string   "dose"
    t.text     "description",            limit: 16777215
    t.date     "date_prescribed"
    t.date     "date_expired"
    t.integer  "total_refills"
    t.integer  "refills_left"
    t.integer  "medication_status_id"
    t.text     "medication_description", limit: 16777215
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "rxcui"
    t.text     "medication_name",        limit: 16777215
    t.text     "medication_synonym",     limit: 16777215
    t.string   "medication_tty"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_medications_on_user_id", using: :btree
  end

  create_table "memberships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.integer  "user_id"
    t.integer  "level"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "body",          limit: 16777215
    t.integer  "user_id"
    t.integer  "chat_room_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["chat_room_id"], name: "index_messages_on_chat_room_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "military_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "text"
    t.integer  "service_type_id"
    t.integer  "service_status_id"
    t.date     "date_started"
    t.date     "date_ended"
    t.text     "note",              limit: 16777215
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["user_id"], name: "index_military_histories_on_user_id", using: :btree
  end

  create_table "mindmap_mind_maps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["user_id"], name: "index_mindmap_mind_maps_on_user_id", using: :btree
  end

  create_table "mtf_hospitals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "mtf_hospital"
    t.integer  "user_id"
    t.integer  "incident_enum_id"
    t.integer  "incident_type_id"
    t.integer  "incident_category_id"
    t.date     "date_of_incident"
    t.date     "date_diagnosed"
    t.string   "incident_location_address"
    t.string   "incident_location_city"
    t.integer  "state_id"
    t.integer  "country_id"
    t.integer  "operation_id"
    t.integer  "verified_personnel_casualty_reporting_system_id"
    t.integer  "line_of_duty_investigation_id"
    t.string   "cause_of_injury"
    t.text     "injury_description",                              limit: 16777215
    t.string   "pending_operation_procedure"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_mtf_hospitals_on_user_id", using: :btree
  end

  create_table "need_goals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "need_id"
    t.integer  "goal_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "needs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "need_enum_id"
    t.integer  "priority_type_id"
    t.integer  "need_status_id"
    t.text     "description",      limit: 16777215
    t.date     "date_due"
    t.date     "date_completed"
    t.date     "date_identified"
    t.integer  "user_id"
    t.integer  "case_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "assigned_to_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.integer  "percent_done"
    t.index ["assigned_to_id"], name: "index_needs_on_assigned_to_id", using: :btree
  end

  create_table "news", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "summary"
    t.text     "description",   limit: 16777215
    t.integer  "user_id"
    t.integer  "notes_count"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "note_templates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "note",          limit: 16777215
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.integer  "owner_id"
    t.text     "note",              limit: 16777215
    t.integer  "user_id"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "is_private",                         default: false
    t.integer  "private_author_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["owner_id"], name: "index_notes_on_owner_id", using: :btree
    t.index ["type"], name: "index_notes_on_type", using: :btree
    t.index ["user_id"], name: "index_notes_on_user_id", using: :btree
  end

  create_table "occupations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_occupations_on_code", using: :btree
    t.index ["name"], name: "index_occupations_on_name", using: :btree
  end

  create_table "old_passwords", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "encrypted_password",       null: false
    t.string   "password_archivable_type", null: false
    t.string   "password_salt"
    t.integer  "password_archivable_id",   null: false
    t.datetime "created_at"
    t.index ["password_archivable_type", "password_archivable_id"], name: "index_password_archivable", using: :btree
  end

  create_table "organizations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "address_id"
    t.text     "note",                 limit: 16777215
    t.integer  "contact_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "activity_id"
    t.integer  "organization_type_id"
    t.integer  "address_type_id"
    t.integer  "user_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "other_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "icdcm_code_id"
    t.date     "date_identified"
    t.date     "date_resolved"
    t.integer  "other_history_status_id"
    t.integer  "other_history_type_id"
    t.text     "description",             limit: 16777215
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "name"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_other_histories_on_user_id", using: :btree
  end

  create_table "other_skills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "name"
    t.date     "date_received"
    t.date     "date_expired"
    t.text     "note",              limit: 16777215
    t.string   "file"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "is_private",                         default: false
    t.integer  "private_author_id"
    t.integer  "status_id"
    t.integer  "skill_type_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "phones", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "phone_number"
    t.integer  "phone_type_id"
    t.integer  "extend_demography_id"
    t.text     "note",                 limit: 16777215
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "place_of_services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code"
    t.string   "name"
    t.text     "description",   limit: 16777215
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["code"], name: "index_place_of_services_on_code", using: :btree
    t.index ["name"], name: "index_place_of_services_on_name", using: :btree
  end

  create_table "plan_tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "plan_id"
    t.integer  "task_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "priority_type_id"
    t.integer  "plan_status_id"
    t.text     "description",      limit: 16777215
    t.date     "date_start"
    t.date     "date_due"
    t.date     "date_completed"
    t.integer  "user_id"
    t.integer  "case_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "assigned_to_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.integer  "percent_done"
    t.integer  "plan_type_id"
    t.index ["assigned_to_id"], name: "index_plans_on_assigned_to_id", using: :btree
  end

  create_table "points", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "link_id"
    t.integer  "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_points_on_comment_id", using: :btree
    t.index ["link_id"], name: "index_points_on_link_id", using: :btree
    t.index ["user_id"], name: "index_points_on_user_id", using: :btree
  end

  create_table "positions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "position_description",     limit: 16777215
    t.string   "location"
    t.string   "special_requirement"
    t.text     "note",                     limit: 16777215
    t.date     "date_start"
    t.date     "date_end"
    t.string   "files"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "location_type_id"
    t.integer  "organization_id"
    t.string   "salary"
    t.integer  "pay_rate_id"
    t.integer  "employment_type_id"
    t.integer  "status_id"
    t.string   "estimated_monthly_amount"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.integer  "occupation_id"
    t.string   "snomed"
  end

  create_table "problem_lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "icdcm_code_id"
    t.integer  "user_id"
    t.date     "date_onset"
    t.date     "date_resolved"
    t.integer  "problem_status_id"
    t.integer  "problem_type_id"
    t.text     "description",       limit: 16777215
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "name"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.string   "snomed"
    t.index ["user_id"], name: "index_problem_lists_on_user_id", using: :btree
  end

  create_table "radiologic_examinations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "facility"
    t.date     "date"
    t.text     "result",                      limit: 16777215
    t.integer  "radiologic_result_status_id"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "snomed"
    t.index ["user_id"], name: "index_radiologic_examinations_on_user_id", using: :btree
  end

  create_table "referral_relations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "referral_parent_id"
    t.integer  "referral_child_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["referral_child_id"], name: "index_referral_relations_on_referral_child_id", using: :btree
    t.index ["referral_parent_id"], name: "index_referral_relations_on_referral_parent_id", using: :btree
  end

  create_table "referral_results", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "referral_id"
    t.date     "result_date"
    t.text     "result",        limit: 16777215
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["referral_id"], name: "index_referral_results_on_referral_id", using: :btree
    t.index ["user_id"], name: "index_referral_results_on_user_id", using: :btree
  end

  create_table "referrals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "referral_type_id"
    t.date     "referral_date"
    t.datetime "referral_appointment"
    t.integer  "referral_status_id"
    t.integer  "referred_by_id"
    t.integer  "referred_to_id"
    t.text     "referral_reason",      limit: 16777215
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "case_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.integer  "related_reason_id"
    t.string   "related_reason_type"
    t.string   "referred_to_address"
    t.index ["case_id"], name: "index_referrals_on_case_id", using: :btree
    t.index ["user_id"], name: "index_referrals_on_user_id", using: :btree
  end

  create_table "related_clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "related_client_id"
    t.integer  "relationship_id"
    t.date     "date_start"
    t.date     "date_end"
    t.text     "description",       limit: 16777215
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "snomed"
    t.index ["user_id"], name: "index_related_clients_on_user_id", using: :btree
  end

  create_table "religions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "religion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resumes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "title"
    t.date     "date"
    t.integer  "resume_type_id"
    t.integer  "resume_status_id"
    t.text     "note",             limit: 16777215
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["user_id"], name: "index_resumes_on_user_id", using: :btree
  end

  create_table "revisions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "document_manager_id"
    t.integer  "user_id"
    t.integer  "position"
    t.integer  "download_count",                       default: 0
    t.string   "file_name"
    t.string   "file_type"
    t.integer  "file_size"
    t.binary   "file_data",           limit: 16777215
    t.text     "search_text",         limit: 16777215
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "state"
    t.text     "note",          limit: 16777215
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "role_type_id"
    t.text     "permissions",   limit: 16777215
    t.string   "name"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "rss_feed_rss_user_feeds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.text     "rss_feed",   limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["user_id"], name: "index_rss_feed_rss_user_feeds_on_user_id", using: :btree
  end

  create_table "service_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "rank_id"
    t.integer  "service_type_id"
    t.integer  "service_status_id"
    t.integer  "component_id"
    t.integer  "discharge_type_id"
    t.date     "date_entered"
    t.date     "end_active_obliged_service"
    t.date     "demobilization"
    t.date     "separation"
    t.date     "temporary_disability_retirement_list"
    t.date     "permanent_disability_retirement_list"
    t.text     "note",                                 limit: 16777215
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_service_histories_on_user_id", using: :btree
  end

  create_table "settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "home_page_content", limit: 16777215
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "setting_type"
    t.text     "value",             limit: 16777215
  end

  create_table "social_media", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "social_media_type_id"
    t.text     "note",                 limit: 16777215
    t.string   "social_media_handle"
    t.integer  "extend_demography_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "socioeconomics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "icdcm_code_id"
    t.date     "date_identified"
    t.date     "date_resolved"
    t.integer  "socioeconomic_status_id"
    t.integer  "socioeconomic_type_id"
    t.text     "description",             limit: 16777215
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "name"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.string   "snomed"
    t.index ["user_id"], name: "index_socioeconomics_on_user_id", using: :btree
  end

  create_table "sticky_notes_sticky_notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.text     "todos",      limit: 16777215
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_sticky_notes_sticky_notes_on_user_id", using: :btree
  end

  create_table "surgicals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "icdcm_code_id"
    t.integer  "user_id"
    t.string   "medical_facility"
    t.date     "surgery_date"
    t.integer  "surgery_status_id"
    t.integer  "surgery_type_id"
    t.text     "description",       limit: 16777215
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "name"
    t.integer  "hcpc_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.float    "location_lat",      limit: 24
    t.float    "location_long",     limit: 24
    t.index ["user_id"], name: "index_surgicals_on_user_id", using: :btree
  end

  create_table "survey_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "attempt_id"
    t.integer  "question_id"
    t.integer  "option_id"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_attempts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "participant_type"
    t.integer "participant_id"
    t.integer "survey_id"
    t.boolean "winner"
    t.integer "score"
  end

  create_table "survey_cases", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "assigned_to_id"
    t.integer  "survey_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
  end

  create_table "survey_options", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "question_id"
    t.integer  "weight",      default: 0
    t.string   "text"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "survey_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_surveys", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description",     limit: 16777215
    t.integer  "attempts_number",                  default: 0
    t.boolean  "finished",                         default: false
    t.boolean  "active",                           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assigned_to_id"
    t.integer  "survey_type_id"
    t.integer  "related_to_id"
    t.string   "related_to_type"
  end

  create_table "survey_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "assigned_to_id"
    t.integer  "survey_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["assigned_to_id"], name: "index_survey_users_on_assigned_to_id", using: :btree
  end

  create_table "task_boards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.text     "todos",         limit: 16777215
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_task_boards_on_user_id", using: :btree
  end

  create_table "task_notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.text     "note",       limit: 16777215
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["task_id"], name: "index_task_notes_on_task_id", using: :btree
    t.index ["user_id"], name: "index_task_notes_on_user_id", using: :btree
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description",         limit: 16777215
    t.integer  "task_type_id"
    t.integer  "priority_id"
    t.datetime "date_start"
    t.date     "date_due"
    t.integer  "user_id"
    t.datetime "date_completed"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "assigned_to_id"
    t.integer  "for_individual_id"
    t.integer  "task_status_type_id"
    t.integer  "sub_task_id"
    t.integer  "related_to_id"
    t.string   "related_to_type"
    t.boolean  "is_private",                           default: false
    t.integer  "private_author_id"
    t.string   "time_spent"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_tasks_on_user_id", using: :btree
  end

  create_table "teleconsults", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "case_id"
    t.integer  "contact_method_id"
    t.integer  "contact_type_id"
    t.integer  "consult_status_id"
    t.date     "date"
    t.string   "time"
    t.text     "note",              limit: 16777215
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["case_id"], name: "index_teleconsults_on_case_id", using: :btree
    t.index ["user_id"], name: "index_teleconsults_on_user_id", using: :btree
  end

  create_table "thredded_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "messageboard_id",             null: false
    t.string   "name",            limit: 191, null: false
    t.string   "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "slug",            limit: 191, null: false
    t.index ["messageboard_id", "slug"], name: "index_thredded_categories_on_messageboard_id_and_slug", unique: true, using: :btree
    t.index ["messageboard_id"], name: "index_thredded_categories_on_messageboard_id", using: :btree
    t.index ["name"], name: "thredded_categories_name_ci", using: :btree
  end

  create_table "thredded_messageboard_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "position",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "thredded_messageboard_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "thredded_user_detail_id",  null: false
    t.integer  "thredded_messageboard_id", null: false
    t.datetime "last_seen_at",             null: false
    t.index ["thredded_messageboard_id", "last_seen_at"], name: "index_thredded_messageboard_users_for_recently_active", using: :btree
    t.index ["thredded_messageboard_id", "thredded_user_detail_id"], name: "index_thredded_messageboard_users_primary", using: :btree
    t.index ["thredded_user_detail_id"], name: "fk_rails_06e42c62f5", using: :btree
  end

  create_table "thredded_messageboards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                  limit: 191,                  null: false
    t.string   "slug",                  limit: 191
    t.text     "description",           limit: 16777215
    t.integer  "topics_count",                           default: 0
    t.integer  "posts_count",                            default: 0
    t.integer  "position",                                           null: false
    t.integer  "last_topic_id"
    t.integer  "messageboard_group_id"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.index ["messageboard_group_id"], name: "index_thredded_messageboards_on_messageboard_group_id", using: :btree
    t.index ["slug"], name: "index_thredded_messageboards_on_slug", using: :btree
  end

  create_table "thredded_post_moderation_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "post_id"
    t.integer  "messageboard_id"
    t.text     "post_content",              limit: 16777215
    t.integer  "post_user_id"
    t.text     "post_user_name",            limit: 16777215
    t.integer  "moderator_id"
    t.integer  "moderation_state",                           null: false
    t.integer  "previous_moderation_state",                  null: false
    t.datetime "created_at",                                 null: false
    t.index ["messageboard_id", "created_at"], name: "index_thredded_moderation_records_for_display", using: :btree
  end

  create_table "thredded_post_notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",      limit: 191, null: false
    t.integer  "post_id",                null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "post_type",  limit: 191
    t.index ["post_id", "post_type"], name: "index_thredded_post_notifications_on_post", using: :btree
  end

  create_table "thredded_posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.text     "content",          limit: 16777215
    t.string   "ip"
    t.string   "source",                            default: "web"
    t.integer  "postable_id",                                       null: false
    t.integer  "messageboard_id",                                   null: false
    t.integer  "moderation_state",                                  null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.index ["messageboard_id"], name: "index_thredded_posts_on_messageboard_id", using: :btree
    t.index ["moderation_state", "updated_at"], name: "index_thredded_posts_for_display", using: :btree
    t.index ["postable_id"], name: "index_thredded_posts_on_postable_id_and_postable_type", using: :btree
    t.index ["user_id"], name: "index_thredded_posts_on_user_id", using: :btree
  end

  create_table "thredded_private_posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.text     "content",     limit: 16777215
    t.integer  "postable_id",                  null: false
    t.string   "ip"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "thredded_private_topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "last_user_id"
    t.string   "title",                                null: false
    t.string   "slug",         limit: 191,             null: false
    t.integer  "posts_count",              default: 0
    t.string   "hash_id",      limit: 191,             null: false
    t.datetime "last_post_at"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["hash_id"], name: "index_thredded_private_topics_on_hash_id", using: :btree
    t.index ["slug"], name: "index_thredded_private_topics_on_slug", using: :btree
  end

  create_table "thredded_private_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "private_topic_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["private_topic_id"], name: "index_thredded_private_users_on_private_topic_id", using: :btree
    t.index ["user_id"], name: "index_thredded_private_users_on_user_id", using: :btree
  end

  create_table "thredded_topic_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "topic_id",    null: false
    t.integer "category_id", null: false
    t.index ["category_id"], name: "index_thredded_topic_categories_on_category_id", using: :btree
    t.index ["topic_id"], name: "index_thredded_topic_categories_on_topic_id", using: :btree
  end

  create_table "thredded_topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "last_user_id"
    t.string   "title",                                        null: false
    t.string   "slug",             limit: 191,                 null: false
    t.integer  "messageboard_id",                              null: false
    t.integer  "posts_count",                  default: 0,     null: false
    t.boolean  "sticky",                       default: false, null: false
    t.boolean  "locked",                       default: false, null: false
    t.string   "hash_id",          limit: 191,                 null: false
    t.string   "type",             limit: 191
    t.integer  "moderation_state",                             null: false
    t.datetime "last_post_at"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["hash_id"], name: "index_thredded_topics_on_hash_id", using: :btree
    t.index ["messageboard_id", "slug"], name: "index_thredded_topics_on_messageboard_id_and_slug", unique: true, using: :btree
    t.index ["messageboard_id"], name: "index_thredded_topics_on_messageboard_id", using: :btree
    t.index ["moderation_state", "sticky", "updated_at"], name: "index_thredded_topics_for_display", using: :btree
    t.index ["user_id"], name: "index_thredded_topics_on_user_id", using: :btree
  end

  create_table "thredded_user_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                                 null: false
    t.datetime "latest_activity_at"
    t.integer  "posts_count",                 default: 0
    t.integer  "topics_count",                default: 0
    t.datetime "last_seen_at"
    t.integer  "moderation_state",            default: 0, null: false
    t.datetime "moderation_state_changed_at"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["latest_activity_at"], name: "index_thredded_user_details_on_latest_activity_at", using: :btree
    t.index ["moderation_state", "moderation_state_changed_at"], name: "index_thredded_user_details_for_moderations", using: :btree
    t.index ["user_id"], name: "index_thredded_user_details_on_user_id", using: :btree
  end

  create_table "thredded_user_messageboard_preferences", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                                 null: false
    t.integer  "messageboard_id",                         null: false
    t.boolean  "follow_topics_on_mention", default: true, null: false
    t.boolean  "followed_topic_emails",    default: true, null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["user_id", "messageboard_id"], name: "thredded_user_messageboard_preferences_user_id_messageboard_id", unique: true, using: :btree
  end

  create_table "thredded_user_preferences", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                                 null: false
    t.boolean  "follow_topics_on_mention", default: true, null: false
    t.boolean  "notify_on_message",        default: true, null: false
    t.boolean  "followed_topic_emails",    default: true, null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["user_id"], name: "index_thredded_user_preferences_on_user_id", using: :btree
  end

  create_table "thredded_user_private_topic_read_states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                 null: false
    t.integer  "postable_id",             null: false
    t.integer  "page",        default: 1, null: false
    t.datetime "read_at",                 null: false
    t.index ["user_id", "postable_id"], name: "thredded_user_private_topic_read_states_user_postable", unique: true, using: :btree
  end

  create_table "thredded_user_topic_follows", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",              null: false
    t.integer  "topic_id",             null: false
    t.datetime "created_at",           null: false
    t.integer  "reason",     limit: 1
    t.index ["user_id", "topic_id"], name: "thredded_user_topic_follows_user_topic", unique: true, using: :btree
  end

  create_table "thredded_user_topic_read_states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                 null: false
    t.integer  "postable_id",             null: false
    t.integer  "page",        default: 1, null: false
    t.datetime "read_at",                 null: false
    t.index ["user_id", "postable_id"], name: "thredded_user_topic_read_states_user_postable", unique: true, using: :btree
  end

  create_table "todo_list_todos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.text     "todos",      limit: 16777215
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_todo_list_todos_on_user_id", using: :btree
  end

  create_table "transportations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "transportation_mean_id"
    t.integer  "transportation_type_id"
    t.integer  "transportation_accessibility_id"
    t.integer  "transportation_status_id"
    t.text     "description",                     limit: 16777215
    t.string   "estimated_monthly_cost"
    t.date     "date_start"
    t.date     "date_end"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_transportations_on_user_id", using: :btree
  end

  create_table "transports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "reason"
    t.integer  "transport_type_id"
    t.text     "description",           limit: 65535
    t.integer  "transport_location_id"
    t.integer  "transport_status_id"
    t.datetime "date_time"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "case_id"
    t.string   "location"
    t.float    "location_lat",          limit: 24
    t.float    "location_long",         limit: 24
    t.index ["case_id"], name: "index_transports_on_case_id", using: :btree
    t.index ["user_id"], name: "index_transports_on_user_id", using: :btree
  end

  create_table "units", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "unit_enum_id"
    t.integer  "unit_type_id"
    t.integer  "installation_name_id"
    t.date     "date_start"
    t.date     "date_end"
    t.text     "note",                 limit: 16777215
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_units_on_user_id", using: :btree
  end

  create_table "user_insurances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "insurance_id"
    t.integer  "insurance_type_id"
    t.string   "insurance_identifier"
    t.text     "note",                      limit: 16777215
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.date     "issue_date"
    t.date     "expiration_date"
    t.integer  "status_id"
    t.integer  "insurance_relationship_id"
    t.string   "insured_name"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.text     "group_id",                  limit: 16777215
  end

  create_table "user_organizations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                                     default: "",    null: false
    t.string   "login",                                     default: "",    null: false
    t.text     "note",                     limit: 16777215
    t.boolean  "state",                                     default: false
    t.boolean  "admin",                                     default: false
    t.string   "encrypted_password",                        default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                             default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                           default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "avatar"
    t.datetime "deleted_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "database_authenticatable"
    t.string   "ldap_authenticatable",                                      null: false
    t.datetime "last_seen_at"
    t.integer  "role_id"
    t.boolean  "anonyme_user",                              default: false
    t.datetime "password_changed_at"
    t.datetime "last_activity_at"
    t.datetime "expired_at"
    t.string   "unique_session_id",        limit: 20
    t.string   "authy_id"
    t.datetime "last_sign_in_with_authy"
    t.boolean  "authy_enabled",                             default: false
    t.string   "time_zone"
    t.index ["authy_id"], name: "index_users_on_authy_id", using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["expired_at"], name: "index_users_on_expired_at", using: :btree
    t.index ["last_activity_at"], name: "index_users_on_last_activity_at", using: :btree
    t.index ["password_changed_at"], name: "index_users_on_password_changed_at", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  create_table "wiki_page_versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "page_id",                       null: false
    t.integer  "updator_id"
    t.integer  "number"
    t.string   "comment"
    t.string   "path"
    t.string   "title"
    t.text     "content",    limit: 4294967295
    t.datetime "updated_at"
    t.index ["page_id"], name: "index_wiki_page_versions_on_page_id", using: :btree
    t.index ["updator_id"], name: "index_wiki_page_versions_on_updator_id", using: :btree
  end

  create_table "wiki_pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "creator_id"
    t.integer  "updator_id"
    t.string   "path"
    t.string   "title"
    t.text     "content",       limit: 4294967295
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sub_page_id"
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["creator_id"], name: "index_wiki_pages_on_creator_id", using: :btree
    t.index ["path"], name: "index_wiki_pages_on_path", unique: true, using: :btree
  end

  create_table "worker_compensations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.integer  "injury_id"
    t.integer  "compensation_type_id"
    t.integer  "compensation_status_id"
    t.text     "description",                limit: 65535
    t.date     "date_of_compensation_start"
    t.date     "date_of_compensation_end"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "updated_by_id"
    t.integer  "created_by_id"
    t.index ["user_id"], name: "index_worker_compensations_on_user_id", using: :btree
  end

  add_foreign_key "extend_demographies", "users"
  add_foreign_key "job_details", "roles"
  add_foreign_key "job_details", "users"
  add_foreign_key "messages", "chat_rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "thredded_messageboard_users", "thredded_messageboards"
  add_foreign_key "thredded_messageboard_users", "thredded_user_details"
end
