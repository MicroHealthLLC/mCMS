class Appointment < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id, :with_who_type]
  belongs_to :user
  belongs_to :appointment_type, optional: true
  belongs_to :appointment_status, optional: true
  belongs_to :place_of_service, optional: true
  belongs_to :case, optional: true, foreign_key: :related_to_id

  has_many :appointment_notes, foreign_key: :owner_id, dependent: :destroy
  has_many :appointment_captures, dependent: :destroy
  has_many :jsignatures, as: :signature_owner, dependent: :destroy
  has_many :appointment_dispositions, dependent: :destroy
  has_many :appointment_procedures, dependent: :destroy
  has_many :appointment_links, dependent: :destroy
  has_many :billings, dependent: :destroy

  has_many :appointment_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :appointment_attachments, reject_if: :all_blank, allow_destroy: true


  validates_presence_of :date, :title, :with_who_id, :with_who_type

  # attr_accessor :with_who

  scope :not_related, -> {where(related_to_id: nil)}

  scope :my_appointment_created, -> { where(user_id: User.current.id)}
  scope :my_appointment_for_me, -> { where(with_who_id: User.current.id).where(with_who_type: "User")}

  def self.include_enumerations
    includes(:user, :case, :appointment_type, :appointment_status).
        references(:user, :case, :appointment_type, :appointment_status)
  end

  def self.enumeration_columns
    [
        ["#{AppointmentType}", 'appointment_type_id'],
        ["#{AppointmentStatus}", 'appointment_status_id']
    ]
  end

  def self.csv_attributes
    %w(client title type status date)
  end

  def to_s
    title
  end

  def visible?
    User.current == user
  end

  def appointment_type
    if appointment_type_id
      super
    else
      AppointmentType.default
    end
  end

  def little_description
    output = '<p>Appointment</p>'
    output<< "<p> #{appointment_type} </p>"
    output<< "<p> From: #{start_time_to_time} </p>"
    output<< "<p> To: #{end_time_to_time} </p>"

    output.html_safe
  end

  def self.my_appointments
    my_appointment_created.or(Appointment.my_appointment_for_me)
  end


  def appointment_status
    if appointment_status_id
      super
    else
      AppointmentStatus.default
    end
  end

  def date_time
    date.to_s
  end

  def  start_time
    date
  end

  def start_time_to_time
    date.strftime("#{Setting['format_date']} %I:%M %p") if date
  end

  def end_time_to_time
    end_time.strftime("#{Setting['format_date']} %I:%M %p") if end_time
  end

  def with_who
    with_who_type.constantize.find(with_who_id)
  rescue StandardError => e
    'No data given'
  end

  def with_who=(user_or_contact)
    if user_or_contact.class == User
      self.with_who_id = user_or_contact.try(:id)
      self.with_who_type = user_or_contact.class
    end
  end

  def name
    title
  end


  def self.safe_attributes
    [:title, :description, :time, :with_who_id, :with_who_type,
     :appointment_type_id, :appointment_status_id, :end_time, :place_of_service_id,
     :user_id, :date, :related_to_id, appointment_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Apointment ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Appointment"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Appointment type: ", " #{appointment_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Appointment status: ", " #{appointment_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date: ", " #{date.strftime("#{Setting['format_date']} %I:%M %p") if date}"]], :column_widths => [ 150, 373])
    pdf.table([[ "With: ", " #{with_who}"]], :column_widths => [ 150, 373])

  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Appointment ##{id} </h2>"
    output<<"<b>Appointment Type: </b> #{appointment_type}<br/>"
    output<<"<b>Appointment Status: </b> #{appointment_status}<br/>"
    output<<"<b>Date: </b> #{date.strftime("#{Setting['format_date']} %I:%M %p") if date}<br/>"
    output<<"<b>Description: </b> #{description} <br/>"
    output.html_safe
  end

  def get_cmf_form_data
    @user = self.user
    @user_insurance = @user.user_insurances.includes(:insurance).references(:insurance).first
    hash = {}

    # User information
    @user_address = @user.addresses.first || Address.new
    @user_phone = @user.phone

    hash.merge!({
                    "pt_name"=> @user.name,
                    "birth_mm"=> @user.birthday.try(:month),
                    "birth_dd"=> @user.birthday.try(:day),
                    "birth_yy"=> @user.birthday.try(:year),
                    "sex"=> @user.gender.to_s[0],
                    "pt_street"=> @user_address.address,
                    "pt_city"=> @user_address.city.to_s,
                    "pt_state"=> @user_address.state_type.to_s,
                    "pt_zip"=> @user_address.zip_code,
                    "pt_AreaCode"=>"",
                    "pt_phone"=> @user_phone.phone_number,
                    "pt_signature"=>"#{@user.jsignatures.last.try(:id)}",
                    "pt_date"=> @user.jsignatures.last.try(:created_at).try(:to_date),
                    "pt_account"=> @user.id,
                })

    if @user_insurance
      @insurance = @user_insurance.insurance
      # Insurance information
      hash.merge!({
                      "insurance_name"=> @insurance.name,
                      "insurance_address"=> @insurance.address,
                      "insurance_address2"=> @insurance.second_address,
                      "insurance_city_state_zip"=> @insurance.city_state_zip,
                  })

      # insured information
      @insured = [@user.contacts + [@user]].flatten.detect{|v| v.name == @user_insurance.insured_name }
      @insured_address = if @insured == @user
                           @user_address
                         elsif @insured.nil? or @insured.contact_extend_demography.nil?
                           Address.new
                         else
                           @insured.contact_extend_demography.default_address
                         end
      @insured_phone = if @insured == @user
                         @user_phone
                       elsif @insured.nil? or @insured.contact_extend_demography.nil?
                         Phone.new
                       else
                         @insured.contact_extend_demography.default_phone
                       end
      hash.merge!({
                      "rel_to_ins"=> @user_insurance.insurance_relationship.to_s[0],
                      "insurance_id"=> @user_insurance.insurance_identifier,
                      "ins_name"=> @user_insurance.insured_name,
                      "insurance_type"=> @user_insurance.insurance_type.to_s,
                      "ins_street"=> @insured_address.address,
                      "ins_city"=> @insured_address.city.to_s,
                      "ins_state"=> @insured_address.state_type.to_s,
                      "ins_zip"=> @insured_address.zip_code,
                      "ins_phone area"=> "",
                      "ins_phone"=> @insured_phone.phone_number,
                      "ins_policy"=>@user_insurance.group_id,
                      "ins_signature"=> "",
                      "ins_benefit_plan"=> "",
                      "ins_plan_name"=> @insurance.name,
                  })

      if @insured
        hash.merge!({
                        "ins_dob_mm"=> @insured.birthday.try(:month),
                        "ins_dob_dd"=> @insured.birthday.try(:day),
                        "ins_dob_yy"=> @insured.birthday.try(:year),
                        "ins_sex"=> @insured.gender.to_s[0],
                    })
      end
    end

    # Second insured information
    @user_second_insurance = @user.user_insurances.count > 1 ? @user.user_insurances.last : UserInsurance.new

    hash.merge!({
                    "other_ins_name"      => @user_second_insurance.insured_name,
                    "other_ins_plan_name" => @user_second_insurance.insurance.to_s,
                    "other_ins_policy"    => @user_second_insurance.group_id,
                })

    # From Deposite
    @deposites = appointment_dispositions.map{|d| d.related_to.to_s }
    hash.merge!({
                    "employment"          => @deposites.include?("Employment") ? 'YES' : 'NO',
                    "pt_auto_accident"    => @deposites.include?("Auto Accident") ? 'YES' : 'NO',
                    "accident_place"      => "",
                    "other_accident"      => @deposites.include?("Other Accident") ? 'YES' : 'NO',
                })

    # Date of current Illness
    hash.merge!({
                    # "73"=>"73",
                    "cur_ill_mm"=> self.date.try(:month),
                    "cur_ill_dd"=> self.date.try(:day),
                    "cur_ill_yy"=> self.date.try(:year),
                })
    # Diagnosis of nature Of illness

    self.appointment_captures.each_with_index do |assessment, idx|
      hash.merge!({
                      "diagnosis#{idx+1}"=> assessment.icdcm_code.try(:name)
                  })
    end

    billing = self.billings.first
    if billing
      # Outside lab
      hash.merge!({
                      "lab"=> billing.outside_lab.to_s.upcase,
                      "charge"=>billing.outside_lab_charges,
                      "assignment"=> billing.accept_assignment.to_s.upcase,
                  })
      # Resubmission
      hash.merge!({
                      "medicaid_resub"=> billing.resubmission_code,
                      "original_ref"=> billing.original_reference_number,
                  })
      # Prio authorization number
      hash.merge!({
                      "prior_auth"=> billing.prior_authorization_number,
                  })

      #Amount Paid
      hash.merge!({
                      "t_charge"=> billing.total_charge,
                      "amt_paid"=> billing.amount_paid,
                  })
      # #
    end

    #Table
    procedures = self.appointment_procedures.includes(:hcpc, :epsdt, :provider).
        references(:hcpc, :epsdt, :provider)
    procedures.each_with_index do |procedure, idx|
      idx += 1
      l = case idx
            when 1 then ''
            when 2 then 'a'
            when 3 then 'b'
            when 4 then 'c'
            when 5 then 'd'
            when 6 then 'e'
            else
              'x'
          end
      hash.merge!({
                      "Suppl#{l}"             => procedure.to_s,
                  })

      hash.merge!({
                      "sv#{idx}_mm_from"  => self.date.try(:month),
                      "sv#{idx}_dd_from"  => self.date.try(:day),
                      "sv#{idx}_yy_from"  => self.date.try(:year),
                      "sv#{idx}_mm_end"   => self.end_time.try(:month),
                      "sv#{idx}_dd_end"   => self.end_time.try(:day),
                      "sv#{idx}_yy_end"   => self.end_time.try(:year),

                      "place#{idx}"       => self.place_of_service.try(:code),
                      "ch#{idx}"          => procedure.charges,
                      "day#{idx}"         => procedure.unit,
                      "diag#{idx}"        => procedure.diagnosis_pointer,
                      # "emg#{idx}"         =>  "emg#{idx}",
                      "local#{idx}"       => procedure.provider.to_s,
                      "cpt#{idx}"         => procedure.hcpc.try(:hcpc),

                      "epsdt#{idx}"       => procedure.epsdt.to_s,

                      # "plan#{idx}"        => "plan#{idx}",

                      "mod#{idx}"         => procedure.modifier,

                      "type#{idx}"        => procedure.emergency.to_s,



                  })
    end
    # Organization
    organization = @user.organization

    if organization
      hash.merge!({
                      "fac_name"=> organization.name,
                      "fac_street"=> organization.address.address,
                      "fac_location"=> organization.address.city.to_s,
                  })
      hash.merge!({
                      "doc_name"=> organization.name,
                      "doc_street"=> organization.address.address,
                      "doc_location"=> organization.address.city.to_s,
                      "doc_phone area"=>"",
                      "doc_phone"=> organization.phone.phone_number,
                  })

      identifications = organization.extend_informations.try(:identifications)
      if identifications.present?
        npi = identifications.detect{|i| i.identification_type.to_s.upcase == 'National Provider Identification'} || Identification.new
        hash.merge!({
                        "grp1"        => npi.identification_number,
                        "grp"           =>  npi.identification_number,
                    })
        tax = identifications.detect{|i| i.identification_type.to_s.upcase == 'Federal Tax Identification Number'} || Identification.new

        hash.merge!({
                        "tax_id"          =>  tax.identification_number,
                    })
      end

    end


    hash.merge!({
                    "135"=>"",
                    "157"=>"",
                    "179"=>"",
                    "201"=>"",
                    "223"=>"",
                    "245"=>"",
                    "276"=>"",

                    "physician_signature"=>"",
                    "physician_date"=>"",
                })
    hash
  end

end
