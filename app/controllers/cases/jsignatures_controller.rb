class JsignaturesController < UserCasesController

  before_action :set_jsignature, only: [:image, :show, :edit, :update, :destroy]
  before_action :authorize_create, only: [:new, :create]
  before_action :authorize_view, only: [:index, :show, :image]
  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # before_action :set_appointment_links, only: [:show]

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


    if @jsignature.signature_owner_type == 'User'
      @breadcrumbs = []
      add_breadcrumb 'Client Profile', '/profile_record'
      add_breadcrumb 'Signatures', '/profile_record#tabs-signature'
      add_breadcrumb @owner.to_s, @jsignature
    else
      add_breadcrumb @owner.to_s, @owner
      if @owner.is_a? Case
        add_breadcrumb I18n.t(:jsignatures), case_path(@owner) + '#tabs-signatures'
      end
      add_breadcrumb @jsignature, @jsignature
    end

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

    respond_to do |format|
      if @jsignature.save
        set_link_to_appointment(@jsignature)
        format.html { redirect_to @jsignature, notice: 'Jsignature was successfully created.' }
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
        format.html { redirect_to @jsignature, notice: 'Jsignature was successfully updated.' }
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
      format.html { redirect_to jsignatures_url, notice: 'Jsignature was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_jsignature
    @jsignature = Jsignature.find(params[:id])
    @owner = @jsignature.signature_owner

    if @jsignature.signature_owner_type == 'User'
      @breadcrumbs = []
      add_breadcrumb 'Client Profile', '/profile_record'
      add_breadcrumb 'Signatures', '/profile_record#tabs-signature'
      add_breadcrumb @owner.to_s, @jsignature
    else
      add_breadcrumb @owner.to_s, @owner
      if @owner.is_a? Case
        add_breadcrumb I18n.t(:jsignatures), case_path(@owner) + '#tabs-signatures'
      end
      add_breadcrumb @jsignature, @jsignature
    end

  rescue ActiveRecord::RecordNotFound
    render_404
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
