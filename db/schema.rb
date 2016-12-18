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

ActiveRecord::Schema.define(version: 20161218101904) do

  create_table "addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "address_type_id"
    t.string   "address"
    t.string   "city"
    t.string   "zip_code"
    t.string   "state"
    t.string   "country_code"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "extend_demography_id"
    t.integer  "country_id"
    t.integer  "state_id"
    t.string   "second_address"
  end

  create_table "affiliations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "affiliation_type_id"
    t.text     "note",                limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "appointments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.text     "description",           limit: 65535
    t.integer  "appointment_type_id"
    t.date     "date"
    t.string   "time"
    t.integer  "appointment_status_id"
    t.integer  "user_id"
    t.integer  "with_who_id"
    t.string   "with_who_type"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "related_to_id"
  end

  create_table "attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "type"
    t.string   "file"
    t.string   "description"
    t.integer  "owner_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "case_relations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "case_id"
    t.string   "relation_type"
    t.integer  "relation_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "cases", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.integer  "priority_id"
    t.integer  "case_type_id"
    t.date     "date_start"
    t.date     "date_due"
    t.date     "date_completed"
    t.integer  "assigned_to_id"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "subcase_id"
    t.text     "note",                limit: 65535
    t.integer  "case_status_type_id"
    t.integer  "case_category_id"
    t.text     "description",         limit: 65535
    t.boolean  "is_private",                        default: false
    t.integer  "private_author_id"
    t.integer  "user_id"
  end

  create_table "certifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "certification_type_id"
    t.integer  "user_id"
    t.date     "date_received"
    t.text     "note",                  limit: 65535
    t.date     "date_expired"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "file"
  end

  create_table "chat_rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "receiver_id"
    t.string   "token"
    t.boolean  "message_seen", default: true
    t.index ["user_id"], name: "index_chat_rooms_on_user_id", using: :btree
  end

  create_table "checklist_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.boolean  "status"
    t.integer  "user_id"
    t.integer  "checklist_id"
    t.integer  "checklist_template_id"
    t.date     "due_date"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "checklist_cases", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "assigned_to_id"
    t.integer  "checklist_template_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "checklist_templates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "checklist_type"
    t.integer  "user_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "title"
    t.text     "description",              limit: 65535
    t.integer  "related_to_id"
    t.string   "related_to_type"
    t.integer  "checklist_status_type_id"
  end

  create_table "checklist_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "assigned_to_id"
    t.integer  "checklist_template_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "checklists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.boolean  "status"
    t.string   "description"
    t.date     "due_date"
    t.integer  "user_id"
    t.integer  "checklist_template_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "clearances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "clearence_type_id"
    t.integer  "user_id"
    t.date     "date_received"
    t.text     "note",              limit: 65535
    t.date     "date_expired"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "file"
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.boolean  "emergency_contact"
    t.text     "note",              limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "contact_type_id"
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "file"
  end

  create_table "core_demographics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.integer  "gender_id"
    t.date     "birth_date"
    t.integer  "religion_id"
    t.string   "title"
    t.text     "note",                limit: 65535
    t.integer  "ethnicity_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "citizenship_type_id"
  end

  create_table "departments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.text     "note",               limit: 65535
    t.date     "date_start"
    t.date     "date_end"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "department_type_id"
    t.integer  "organization_id"
  end

  create_table "documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.text     "description",       limit: 65535
    t.integer  "user_id"
    t.integer  "document_type_id"
    t.date     "date"
    t.string   "attachment"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "related_to_id"
    t.string   "related_to_type"
    t.boolean  "is_private",                      default: false
    t.integer  "private_author_id"
  end

  create_table "educations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "education_type"
    t.string   "other_skill"
    t.date     "date_recieved"
    t.date     "date_expired"
    t.text     "note",                  limit: 65535
    t.integer  "clearence"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "user_id"
    t.integer  "education_type_id"
    t.integer  "certification_type_id"
    t.string   "file"
  end

  create_table "emails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "email_address"
    t.integer  "email_type_id"
    t.integer  "extend_demography_id"
    t.text     "note",                 limit: 65535
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "enabled_modules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.boolean  "status",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "enumerations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string  "name",          limit: 30, default: "",    null: false
    t.integer "position"
    t.boolean "is_default",               default: false, null: false
    t.string  "type"
    t.boolean "active",                   default: true,  null: false
    t.string  "position_name", limit: 30
  end

  create_table "extend_demographies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "type"
    t.integer  "department_id"
    t.integer  "contact_id"
    t.integer  "organization_id"
    t.integer  "affiliation_id"
    t.integer  "insurance_id"
    t.index ["user_id"], name: "index_extend_demographies_on_user_id", using: :btree
  end

  create_table "faxes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "fax_number"
    t.integer  "fax_type_id"
    t.integer  "extend_demography_id"
    t.text     "note",                 limit: 65535
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "friendly_id_slugs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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

  create_table "identifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "identification_number"
    t.boolean  "status"
    t.date     "date_expired"
    t.string   "date_issued"
    t.text     "note",                   limit: 65535
    t.integer  "identification_type_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "extend_demography_id"
    t.integer  "issued_by_type_id"
  end

  create_table "insurances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.text     "note",            limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "organization_id"
    t.index ["role_id"], name: "index_job_details_on_role_id", using: :btree
    t.index ["user_id"], name: "index_job_details_on_user_id", using: :btree
  end

  create_table "journal_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.text     "answer",     limit: 65535
    t.integer  "journal_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "journals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "journal_type_id"
    t.text     "question",        limit: 65535
    t.integer  "user_id"
    t.integer  "assigned_to_id"
    t.date     "due_date"
    t.date     "date_completed"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.integer  "language_type_id"
    t.integer  "proficiency_id"
    t.text     "note",             limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text     "body",         limit: 65535
    t.integer  "user_id"
    t.integer  "chat_room_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["chat_room_id"], name: "index_messages_on_chat_room_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "news", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.string   "summary"
    t.text     "description", limit: 65535
    t.integer  "user_id"
    t.integer  "notes_count"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "type"
    t.integer  "owner_id"
    t.text     "note",              limit: 65535
    t.integer  "user_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.boolean  "is_private",                      default: false
    t.integer  "private_author_id"
    t.index ["owner_id"], name: "index_notes_on_owner_id", using: :btree
    t.index ["type"], name: "index_notes_on_type", using: :btree
    t.index ["user_id"], name: "index_notes_on_user_id", using: :btree
  end

  create_table "organizations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.integer  "address_id"
    t.text     "note",                 limit: 65535
    t.integer  "contact_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "activity_id"
    t.integer  "organization_type_id"
    t.integer  "address_type_id"
    t.integer  "user_id"
  end

  create_table "other_skills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.string   "name"
    t.date     "date_received"
    t.date     "date_expired"
    t.text     "note",              limit: 65535
    t.string   "file"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.boolean  "is_private",                      default: false
    t.integer  "private_author_id"
  end

  create_table "phones", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "phone_number"
    t.integer  "phone_type_id"
    t.integer  "extend_demography_id"
    t.text     "note",                 limit: 65535
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "positions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "position_description", limit: 65535
    t.string   "location"
    t.string   "special_requirement"
    t.text     "note",                 limit: 65535
    t.date     "date_start"
    t.date     "date_end"
    t.string   "files"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "location_type_id"
    t.integer  "organization_id"
    t.string   "salary"
    t.integer  "pay_rate_id"
    t.integer  "employment_type_id"
  end

  create_table "religions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "religion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.boolean  "state"
    t.text     "note",         limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "role_type_id"
    t.text     "permissions",  limit: 65535
  end

  create_table "settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text     "home_page_content", limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "setting_type"
    t.text     "value",             limit: 65535
  end

  create_table "social_media", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "social_media_type_id"
    t.text     "note",                 limit: 65535
    t.string   "social_media_handle"
    t.integer  "extend_demography_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "survey_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "attempt_id"
    t.integer  "question_id"
    t.integer  "option_id"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_attempts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string  "participant_type"
    t.integer "participant_id"
    t.integer "survey_id"
    t.boolean "winner"
    t.integer "score"
  end

  create_table "survey_cases", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "assigned_to_id"
    t.integer  "survey_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "survey_options", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "question_id"
    t.integer  "weight",      default: 0
    t.string   "text"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "survey_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_surveys", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.text     "description",     limit: 65535
    t.integer  "attempts_number",               default: 0
    t.boolean  "finished",                      default: false
    t.boolean  "active",                        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assigned_to_id"
    t.integer  "survey_type_id"
    t.integer  "related_to_id"
    t.string   "related_to_type"
  end

  create_table "survey_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "assigned_to_id"
    t.integer  "survey_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["assigned_to_id"], name: "index_survey_users_on_assigned_to_id", using: :btree
  end

  create_table "talking_stick_participants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "ip"
    t.string   "guid"
    t.datetime "joined_at"
    t.datetime "last_seen"
    t.integer  "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guid"], name: "index_talking_stick_participants_on_guid", using: :btree
    t.index ["room_id"], name: "index_talking_stick_participants_on_room_id", using: :btree
  end

  create_table "talking_stick_rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.datetime "last_used"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "talking_stick_signals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "room_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "signal_type"
    t.text     "data",         limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["recipient_id"], name: "index_talking_stick_signals_on_recipient_id", using: :btree
    t.index ["sender_id"], name: "index_talking_stick_signals_on_sender_id", using: :btree
  end

  create_table "task_notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.text     "note",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["task_id"], name: "index_task_notes_on_task_id", using: :btree
    t.index ["user_id"], name: "index_task_notes_on_user_id", using: :btree
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.text     "description",         limit: 65535
    t.integer  "task_type_id"
    t.integer  "priority_id"
    t.date     "date_start"
    t.date     "date_due"
    t.integer  "user_id"
    t.date     "date_completed"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "assigned_to_id"
    t.integer  "for_individual_id"
    t.integer  "task_status_type_id"
    t.integer  "sub_task_id"
    t.integer  "related_to_id"
    t.string   "related_to_type"
    t.boolean  "is_private",                        default: false
    t.integer  "private_author_id"
    t.index ["user_id"], name: "index_tasks_on_user_id", using: :btree
  end

  create_table "thredded_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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

  create_table "thredded_messageboard_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.integer  "position",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "thredded_messageboard_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "thredded_user_detail_id",  null: false
    t.integer  "thredded_messageboard_id", null: false
    t.datetime "last_seen_at",             null: false
    t.index ["thredded_messageboard_id", "last_seen_at"], name: "index_thredded_messageboard_users_for_recently_active", using: :btree
    t.index ["thredded_messageboard_id", "thredded_user_detail_id"], name: "index_thredded_messageboard_users_primary", using: :btree
    t.index ["thredded_user_detail_id"], name: "fk_rails_06e42c62f5", using: :btree
  end

  create_table "thredded_messageboards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name",                  limit: 191,               null: false
    t.string   "slug",                  limit: 191
    t.text     "description",           limit: 65535
    t.integer  "topics_count",                        default: 0
    t.integer  "posts_count",                         default: 0
    t.integer  "position",                                        null: false
    t.integer  "last_topic_id"
    t.integer  "messageboard_group_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.index ["messageboard_group_id"], name: "index_thredded_messageboards_on_messageboard_group_id", using: :btree
    t.index ["slug"], name: "index_thredded_messageboards_on_slug", using: :btree
  end

  create_table "thredded_post_moderation_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "post_id"
    t.integer  "messageboard_id"
    t.text     "post_content",              limit: 65535
    t.integer  "post_user_id"
    t.text     "post_user_name",            limit: 65535
    t.integer  "moderator_id"
    t.integer  "moderation_state",                        null: false
    t.integer  "previous_moderation_state",               null: false
    t.datetime "created_at",                              null: false
    t.index ["messageboard_id", "created_at"], name: "index_thredded_moderation_records_for_display", using: :btree
  end

  create_table "thredded_post_notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "email",      limit: 191, null: false
    t.integer  "post_id",                null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "post_type",  limit: 191
    t.index ["post_id", "post_type"], name: "index_thredded_post_notifications_on_post", using: :btree
  end

  create_table "thredded_posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.text     "content",          limit: 65535
    t.string   "ip"
    t.string   "source",                         default: "web"
    t.integer  "postable_id",                                    null: false
    t.integer  "messageboard_id",                                null: false
    t.integer  "moderation_state",                               null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.index ["content"], name: "thredded_posts_content_fts", type: :fulltext
    t.index ["messageboard_id"], name: "index_thredded_posts_on_messageboard_id", using: :btree
    t.index ["moderation_state", "updated_at"], name: "index_thredded_posts_for_display", using: :btree
    t.index ["postable_id"], name: "index_thredded_posts_on_postable_id_and_postable_type", using: :btree
    t.index ["user_id"], name: "index_thredded_posts_on_user_id", using: :btree
  end

  create_table "thredded_private_posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.text     "content",     limit: 65535
    t.integer  "postable_id",               null: false
    t.string   "ip"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "thredded_private_topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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

  create_table "thredded_private_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "private_topic_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["private_topic_id"], name: "index_thredded_private_users_on_private_topic_id", using: :btree
    t.index ["user_id"], name: "index_thredded_private_users_on_user_id", using: :btree
  end

  create_table "thredded_topic_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "topic_id",    null: false
    t.integer "category_id", null: false
    t.index ["category_id"], name: "index_thredded_topic_categories_on_category_id", using: :btree
    t.index ["topic_id"], name: "index_thredded_topic_categories_on_topic_id", using: :btree
  end

  create_table "thredded_topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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
    t.index ["title"], name: "thredded_topics_title_fts", type: :fulltext
    t.index ["user_id"], name: "index_thredded_topics_on_user_id", using: :btree
  end

  create_table "thredded_user_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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

  create_table "thredded_user_messageboard_preferences", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id",                                 null: false
    t.integer  "messageboard_id",                         null: false
    t.boolean  "follow_topics_on_mention", default: true, null: false
    t.boolean  "followed_topic_emails",    default: true, null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["user_id", "messageboard_id"], name: "thredded_user_messageboard_preferences_user_id_messageboard_id", unique: true, using: :btree
  end

  create_table "thredded_user_preferences", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id",                                 null: false
    t.boolean  "follow_topics_on_mention", default: true, null: false
    t.boolean  "notify_on_message",        default: true, null: false
    t.boolean  "followed_topic_emails",    default: true, null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["user_id"], name: "index_thredded_user_preferences_on_user_id", using: :btree
  end

  create_table "thredded_user_private_topic_read_states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id",                 null: false
    t.integer  "postable_id",             null: false
    t.integer  "page",        default: 1, null: false
    t.datetime "read_at",                 null: false
    t.index ["user_id", "postable_id"], name: "thredded_user_private_topic_read_states_user_postable", unique: true, using: :btree
  end

  create_table "thredded_user_topic_follows", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id",              null: false
    t.integer  "topic_id",             null: false
    t.datetime "created_at",           null: false
    t.integer  "reason",     limit: 1
    t.index ["user_id", "topic_id"], name: "thredded_user_topic_follows_user_topic", unique: true, using: :btree
  end

  create_table "thredded_user_topic_read_states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id",                 null: false
    t.integer  "postable_id",             null: false
    t.integer  "page",        default: 1, null: false
    t.datetime "read_at",                 null: false
    t.index ["user_id", "postable_id"], name: "thredded_user_topic_read_states_user_postable", unique: true, using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "email",                                  default: "",    null: false
    t.string   "login",                                  default: "",    null: false
    t.text     "note",                     limit: 65535
    t.boolean  "state",                                  default: false
    t.boolean  "admin",                                  default: false
    t.string   "encrypted_password",                     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "avatar"
    t.datetime "deleted_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "database_authenticatable"
    t.string   "ldap_authenticatable",                                   null: false
    t.datetime "last_seen_at"
    t.integer  "role_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  create_table "wiki_page_versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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

  create_table "wiki_pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "creator_id"
    t.integer  "updator_id"
    t.string   "path"
    t.string   "title"
    t.text     "content",     limit: 4294967295
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sub_page_id"
    t.index ["creator_id"], name: "index_wiki_pages_on_creator_id", using: :btree
    t.index ["path"], name: "index_wiki_pages_on_path", unique: true, using: :btree
  end

  add_foreign_key "chat_rooms", "users"
  add_foreign_key "extend_demographies", "users"
  add_foreign_key "job_details", "roles"
  add_foreign_key "job_details", "users"
  add_foreign_key "messages", "chat_rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "thredded_messageboard_users", "thredded_messageboards"
  add_foreign_key "thredded_messageboard_users", "thredded_user_details"
end
