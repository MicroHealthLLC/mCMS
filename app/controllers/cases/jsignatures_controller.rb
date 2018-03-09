class JsignaturesController < UserCasesController

  before_action :set_jsignature, only: [:image, :show, :edit, :update, :destroy]
  before_action :authorize_create, only: [:new, :create]
  before_action :authorize_view, only: [:index, :show, :image]
  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # before_action :set_appointment_links, only: [:show]

  include JsignaturesHelper
  def index
    options = Hash.new
    options[:status_type] = params[:status_type]
    options[:show_case] = params[:show_case]
    options[:case_id] = params[:case_id]
    options[:appointment_id] = params[:appointment_id]
    if params[:case_id]
      @case = Case.find params[:case_id]
    end
    if params[:appointment_id]
      @appointment = Appointment.find params[:appointment_id]
    end
    options[:appointment_id] = params[:appointment_id]
    respond_to do |format|
      format.html{  }
      format.js{ render 'application/index' }
      format.pdf{}
      format.csv{
        options[:show_case] = 'true'
        params[:length] = 500
        json = JsignatureDatatable.new(view_context, options).as_json
        send_data Jsignature.to_csv(json[:data]), filename: "Signatures-#{Date.today}.csv"
      }
      format.json{
        render json: JsignatureDatatable.new(view_context,options)
      }
    end

  end

  # GET /jsignatures/1
  # GET /jsignatures/1.json
  def show
  end

  # GET /jsignatures/new
  def new
    @owner = params[:owner_type] == 'User' ? User.find(params[:owner_id]) : params[:owner_type].constantize.visible.find( params[:owner_id])
    @jsignature = Jsignature.new(user_id: User.current_user.id,
                                 signature_owner_type: @owner.class,
                                 signature_owner_id: @owner.id
    )


    set_breadcrumbs

  rescue ActiveRecord::RecordNotFound
    render_404
  rescue StandardError::StandardError
    render_404
  end

  # GET /jsignatures/1/edit
  def edit
  end

  # POST /jsignatures
  # POST /jsignatures.json
  def create
    @jsignature = Jsignature.new(jsignature_params)
    @owner = @jsignature.signature_owner

    set_breadcrumbs
    respond_to do |format|
      if @jsignature.save
        set_link_to_appointment(@jsignature)
        format.html { redirect_to redirect_url, notice: 'Jsignature was successfully created.' }
        format.json { render :show, status: :created, location: @jsignature }
      else
        format.html { render :new }
        format.json { render json: @jsignature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jsignatures/1
  # PATCH/PUT /jsignatures/1.json
  def update
    respond_to do |format|
      if @jsignature.update(jsignature_params)
        format.html { redirect_to redirect_url, notice: 'Jsignature was successfully updated.' }
        format.json { render :show, status: :ok, location: @jsignature }
      else
        format.html { render :edit }
        format.json { render json: @jsignature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jsignatures/1
  # DELETE /jsignatures/1.json
  def destroy
    @jsignature.destroy
    respond_to do |format|
      format.html { redirect_to redirect_url, notice: 'Jsignature was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_jsignature
    @jsignature = Jsignature.find(params[:id])
    @owner = @jsignature.signature_owner
    set_breadcrumbs
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def set_breadcrumbs
    case @jsignature.signature_owner_type
      when 'User'
        @breadcrumbs = []
        add_breadcrumb 'Client Profile', '/profile_record'
        add_breadcrumb 'Signatures', '/profile_record#tabs-signature'
        add_breadcrumb @owner.to_s, @jsignature
      when 'Case'
        add_breadcrumb @owner.to_s, @owner
        add_breadcrumb I18n.t(:jsignatures), case_path(@owner) + '#tabs-signatures'
      when 'Appointment'
        if @owner.case
          add_breadcrumb @owner.case, case_path(@owner.case)
          add_breadcrumb I18n.t(:appointments), case_path(@owner.case) + "#tabs-appointments"
        else
          add_breadcrumb I18n.t(:appointments), appointments_path
        end
        add_breadcrumb @owner.to_s, @owner
        add_breadcrumb I18n.t(:jsignatures), appointment_path(@owner) + '#tabs-signatures'
      when 'UserInsurance'
        add_breadcrumb @owner.to_s, @owner
      else
    end
    add_breadcrumb(@jsignature, @jsignature) if @jsignature.to_s
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def jsignature_params
    params.require(:jsignature).permit(Jsignature.safe_attributes)
  end

  def authorize_create
    raise Unauthorized unless User.current_user.can?(:edit_jsignatures, :manage_jsignatures, :manage_roles)
  end

  def authorize_view
    raise Unauthorized unless User.current_user.can?(:view_jsignatures, :manage_jsignatures, :manage_roles)
  end

  def authorize_edit
    raise Unauthorized unless User.current_user.admin?
  end

  def authorize_delete
    raise Unauthorized unless User.current_user.admin?
  end

  def authorize
    true
  end
end
