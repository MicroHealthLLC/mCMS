class AppointmentsController < UserCasesController
  add_breadcrumb I18n.t(:appointments), :appointments_path

  before_action :set_appointment, only: [:show, :cms_form, :edit, :update, :destroy]
  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    respond_to do |format|
      format.html{}
      format.pdf{
        scope = Appointment
        scope = case params[:status_type]
                  when 'all' then scope.all_data
                  when 'opened' then scope.opened
                  when 'closed' then scope.closed
                  when 'flagged' then scope.flagged
                  else
                    scope.opened
                end
        @appointments = scope.include_enumerations.
            includes(:user=> :core_demographic).
            references(:user=> :core_demographic).
            my_appointments
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: AppointmentDatatable.new(view_context, options)
      }
    end
  end

  def my
    render 'appointments/index'
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
    set_client_profile(@appointment)
    @case =  @appointment.case
    @billings =  @appointment.billings
    # update_rails = @appointment.updated_at.to_date
    @appointment_links = @appointment.appointment_links.includes(:linkable)
    @jsignatures= @appointment.jsignatures
    @cases       = @appointment_links.where(linkable_type: 'Case').map(&:linkable)
    @tasks       = @appointment_links.where(linkable_type: 'Task').map(&:linkable)
    # @surveys     = @case.survey_cases.where('date(updated_at) = ?', update_rails)
    @documents   = @appointment_links.where(linkable_type: 'Document').map(&:linkable)
    # @checklists  = @case.checklists.where('date(updated_at) = ?', update_rails).map(&:checklist_template)
    # @surveys     = @appointment_links.where(linkable_type: 'SurveyCase').map(&:linkable)
    @checklists  = @appointment_links.where(linkable_type: 'ChecklistCase').map(&:linkable)
    @notes       = @appointment_links.where(linkable_type: 'Note').map(&:linkable)
    @appointments= @appointment_links.where(linkable_type: 'Appointment').map(&:linkable)
    @needs       = @appointment_links.where(linkable_type: 'Need').map(&:linkable)
    @plans       = @appointment_links.where(linkable_type: 'Plan').map(&:linkable)
    @goals       = @appointment_links.where(linkable_type: 'Goal').map(&:linkable)
    # @watchers    = @case.watchers.where('date(updated_at) = ?', update_rails).includes(:user=> :core_demographic)
    @case_supports = @appointment_links.where(linkable_type: 'CaseSupport').map(&:linkable)
    @enrollments = @appointment_links.where(linkable_type: 'Enrollment').map(&:linkable)
    @teleconsults = @appointment_links.where(linkable_type: 'Teleconsult').map(&:linkable)
  end

  def cms_form
    @user = @appointment.user
    @user_insurance = @user.user_insurances.first
    hash = {}

    # User information
    @user_address = @user.addresses.first || Address.new
    @user_phone = @user.phone

    hash.merge!({
                    "pt_name"=> @user.name,
                    "birth_mm"=> @user.birthday.month,
                    "birth_dd"=> @user.birthday.day,
                    "birth_yy"=> @user.birthday.year,
                    "sex"=> @user.gender.to_s[0],
                    "pt_street"=> @user_address.address,
                    "pt_city"=> @user_address.city.to_s,
                    "pt_state"=> @user_address.state.to_s,
                    "pt_zip"=> @user_address.zip_code,
                    "pt_AreaCode"=>"",
                    "pt_phone"=> @user_phone.phone_number,
                    "rel_to_ins"=> @user_insurance.insurance_relationship.to_s[0],
                    "pt_signature"=>"",
                    "pt_date"=>""

                })

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
                    "insurance_id"=> @user_insurance.insurance_identifier,
                    "ins_name"=> @user_insurance.insured_name,
                    "insurance_type"=> @user_insurance.insurance_type.to_s,
                    "ins_street"=> @insured_address.address,
                    "ins_city"=> @insured_address.city.to_s,
                    "ins_state"=> @insured_address.state.to_s,
                    "ins_zip"=> @insured_address.zip_code,
                    "ins_phone area"=> "",
                    "ins_phone"=> @insured_phone.phone_number,
                    "ins_policy"=>@user_insurance.group_id,
                    "ins_dob_mm"=>"",
                    "ins_dob_dd"=>"",
                    "ins_dob_yy"=>"",
                    "ins_sex"=> "",
                    "ins_signature"=> "",
                    "ins_benefit_plan"=> "",
                    "ins_plan_name"=> "",
                })

    # Second insured information
    @user_second_insurance = @user.user_insurances.count > 1 ? @user.user_insurances.last : UserInsurance.new

    hash.merge!({
                    "other_ins_name"=> @user_second_insurance.insured_name,
                    "other_ins_policy"=>@user_second_insurance.group_id,
                })


    # Filling PDF
    pdftk = PdfForms.new('/usr/bin/pdftk')
    file_name = "#{Rails.root}/claim-form.pdf"
    pdftk.fill_form file_name, "form_#{@user.id}.pdf", hash

    hash =  {
        "NUCC USE"=>"NUCC USE",
        "40"=>"40",
        "57"=>"57",
        "58"=>"58",
        "41"=>"41",
        "50"=>"50",
        "73"=>"73",
        "74"=>"74",
        "85"=>"85",
        "96"=>"96",
        "99icd"=>"99icd",
        "135"=>"135",
        "157"=>"157",
        "179"=>"179",
        "201"=>"201",
        "223"=>"223",
        "245"=>"245",
        "276"=>"276",

        "cur_ill_mm"=>"cur_ill_mm",
        "cur_ill_dd"=>"cur_ill_dd",
        "cur_ill_yy"=>"cur_ill_yy",
        "ref_physician"=>"ref_physician",
        "id_physician"=>"id_physician",
        "physician number 17a1"=>"physician number 17a1",
        "physician number 17a"=>"physician number 17a",
        "sim_ill_mm"=>"sim_ill_mm",
        "sim_ill_dd"=>"sim_ill_dd",
        "sim_ill_yy"=>"sim_ill_yy",
        "work_mm_from"=>"work_mm_from",
        "work_dd_from"=>"work_dd_from",
        "work_yy_from"=>"work_yy_from",
        "work_mm_end"=>"work_mm_end",
        "work_dd_end"=>"work_dd_end",
        "work_yy_end"=>"work_yy_end",
        "hosp_mm_from"=>"hosp_mm_from",
        "hosp_dd_from"=>"hosp_dd_from",
        "hosp_yy_from"=>"hosp_yy_from",
        "hosp_mm_end"=>"hosp_mm_end",
        "hosp_dd_end"=>"hosp_dd_end",
        "hosp_yy_end"=>"hosp_yy_end",
        "lab"=>"lab",
        "charge"=>"charge",
        "medicaid_resub"=>"medicaid_resub",
        "original_ref"=>"original_ref",
        "prior_auth"=>"prior_auth",
        "emg1"=>"emg1",
        "local1a"=>"local1a",
        "sv1_mm_from"=>"sv1_mm_from",
        "sv1_dd_from"=>"sv1_dd_from",
        "sv1_yy_from"=>"sv1_yy_from",
        "sv1_mm_end"=>"sv1_mm_end",
        "sv1_dd_end"=>"sv1_dd_end",
        "sv1_yy_end"=>"sv1_yy_end",
        "diag1"=>"diag1",
        "ch1"=>"ch1",
        "day1"=>"day1",
        "sv2_mm_from"=>"sv2_mm_from",
        "sv3_mm_from"=>"sv3_mm_from",
        "sv4_mm_from"=>"sv4_mm_from",
        "sv5_mm_from"=>"sv5_mm_from",
        "sv6_mm_from"=>"sv6_mm_from",
        "sv2_dd_from"=>"sv2_dd_from",
        "sv3_dd_from"=>"sv3_dd_from",
        "sv4_dd_from"=>"sv4_dd_from",
        "sv5_dd_from"=>"sv5_dd_from",
        "sv6_dd_from"=>"sv6_dd_from",
        "sv2_yy_from"=>"sv2_yy_from",
        "sv3_yy_from"=>"sv3_yy_from",
        "sv4_yy_from"=>"sv4_yy_from",
        "sv5_yy_from"=>"sv5_yy_from",
        "sv6_yy_from"=>"sv6_yy_from",
        "sv2_mm_end"=>"sv2_mm_end",
        "sv3_mm_end"=>"sv3_mm_end",
        "sv4_mm_end"=>"sv4_mm_end",
        "sv5_mm_end"=>"sv5_mm_end",
        "sv6_mm_end"=>"sv6_mm_end",
        "sv2_dd_end"=>"sv2_dd_end",
        "sv3_dd_end"=>"sv3_dd_end",
        "sv4_dd_end"=>"sv4_dd_end",
        "sv5_dd_end"=>"sv5_dd_end",
        "sv6_dd_end"=>"sv6_dd_end",
        "sv2_yy_end"=>"sv2_yy_end",
        "sv3_yy_end"=>"sv3_yy_end",
        "sv4_yy_end"=>"sv4_yy_end",
        "sv5_yy_end"=>"sv5_yy_end",
        "sv6_yy_end"=>"sv6_yy_end",
        "place2"=>"place2",
        "place3"=>"place3",
        "place4"=>"place4",
        "place5"=>"place5",
        "place6"=>"place6",
        "diag2"=>"diag2",
        "diag3"=>"diag3",
        "diag4"=>"diag4",
        "ch2"=>"ch2",
        "ch3"=>"ch3",
        "ch4"=>"ch4",
        "ch5"=>"ch5",
        "ch6"=>"ch6",
        "Suppla"=>"Suppla",
        "Supplb"=>"Supplb",
        "Supplc"=>"Supplc",
        "Suppld"=>"Suppld",
        "Supple"=>"Supple",
        "day2"=>"day2",
        "day3"=>"day3",
        "day4"=>"day4",
        "day5"=>"day5",
        "day6"=>"day6",
        "emg2"=>"emg2",
        "emg3"=>"emg3",
        "emg4"=>"emg4",
        "emg5"=>"emg5",
        "emg6"=>"emg6",
        "local1"=>"local1",
        "local2a"=>"local2a",
        "local2"=>"local2",
        "local3a"=>"local3a",
        "local3"=>"local3",
        "local4a"=>"local4a",
        "local4"=>"local4",
        "local5a"=>"local5a",
        "local5"=>"local5",
        "local6a"=>"local6a",
        "local6"=>"local6",
        "tax_id"=>"tax_id",
        "pt_account"=>"pt_account",
        "assignment"=>"assignment",
        "t_charge"=>"t_charge",
        "amt_paid"=>"amt_paid",
        "physician_signature"=>"physician_signature",
        "physician_date"=>"physician_date",
        "fac_name"=>"fac_name",
        "fac_street"=>"fac_street",
        "fac_location"=>"fac_location",
        "doc_name"=>"doc_name",
        "doc_street"=>"doc_street",
        "doc_location"=>"doc_location",
        "doc_phone area"=>"doc_phone area",
        "doc_phone"=>"doc_phone",
        "pin"=>"pin",
        "grp"=>"grp",
        "employment"=>"employment",
        "pt_auto_accident"=>"pt_auto_accident",
        "accident_place"=>"accident_place",
        "other_accident"=>"other_accident",
        "other_ins_plan_name"=>"other_ins_plan_name",
        "diagnosis1"=>"diagnosis1",
        "diagnosis4"=>"diagnosis4",
        "diagnosis3"=>"diagnosis3",
        "diagnosis2"=>"diagnosis2",
        "diagnosis5"=>"diagnosis5",
        "diagnosis6"=>"diagnosis6",
        "diagnosis7"=>"diagnosis7",
        "diagnosis8"=>"diagnosis8",
        "diagnosis9"=>"diagnosis9",
        "diagnosis10"=>"diagnosis10",
        "diagnosis11"=>"diagnosis11",
        "diagnosis12"=>"diagnosis12",
        "ssn"=>"ssn",
        "place1"=>"place1",
        "diag6"=>"diag6",
        "diag5"=>"diag5",
        "type6"=>"type6",
        "type5"=>"type5",
        "cpt6"=>"cpt6",
        "cpt5"=>"cpt5",
        "cpt4"=>"cpt4",
        "mod6"=>"mod6",
        "mod5"=>"mod5",
        "mod4"=>"mod4",
        "mod3"=>"mod3",
        "mod2"=>"mod2",
        "mod6a"=>"mod6a",
        "mod5a"=>"mod5a",
        "mod4a"=>"mod4a",
        "mod3a"=>"mod3a",
        "mod2a"=>"mod2a",
        "mod1a"=>"mod1a",
        "mod6b"=>"mod6b",
        "mod5b"=>"mod5b",
        "mod4b"=>"mod4b",
        "mod3b"=>"mod3b",
        "mod2b"=>"mod2b",
        "mod1b"=>"mod1b",
        "mod6c"=>"mod6c",
        "mod5c"=>"mod5c",
        "mod4c"=>"mod4c",
        "mod3c"=>"mod3c",
        "mod1c"=>"mod1c",
        "mod2c"=>"mod2c",
        "type1"=>"type1",
        "type2"=>"type2",
        "type3"=>"type3",
        "type4"=>"type4",
        "cpt1"=>"cpt1",
        "cpt2"=>"cpt2",
        "cpt3"=>"cpt3",
        "mod1"=>"mod1",
        "pin1"=>"pin1",
        "grp1"=>"grp1",
        "Suppl"=>"Suppl",
        "plan1"=>"plan1",
        "plan2"=>"plan2",
        "plan3"=>"plan3",
        "plan4"=>"plan4",
        "plan5"=>"plan5",
        "plan6"=>"plan6",
        "epsdt1"=>"epsdt1",
        "epsdt3"=>"epsdt3",
        "epsdt6"=>"epsdt6",
        "epsdt5"=>"epsdt5",
        "epsdt4"=>"epsdt4",
        "epsdt2"=>"epsdt2"
    }

  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new(user_id: User.current.id,
                                   related_to_id: params[:case_id])
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    # @appointment.with_who = User.find(params[:appointment][:with_who_id]) rescue nil

    respond_to do |format|
      if @appointment.save
        set_link_to_appointment(@appointment)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    # @appointment.with_who = User.find(params[:appointment][:with_who_id]) rescue nil

    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.includes(:appointment_notes, :user=> :core_demographic).
        find(params[:id])
    add_breadcrumb @appointment.to_s, appointment_url(@appointment)
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def appointment_params
    params.require(:appointment).permit(Appointment.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @appointment.can?(:edit_appointments, :manage_appointments, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @appointment.can?(:delete_appointments, :manage_appointments, :manage_roles)
  end

end
