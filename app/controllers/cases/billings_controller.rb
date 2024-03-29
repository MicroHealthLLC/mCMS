class BillingsController < UserProfilesController

  # add_breadcrumb I18n.t('billings'), :billings_path
  before_action :set_appointment, only: [:new]
  before_action :set_billing, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:links, :add_action, :edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /billings
  # GET /billings.json
  def index
    scope = Billing
    scope = case params[:status_type]
              when 'all' then scope.all_data
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.all_data
            end

    if User.current.can?(:manage_roles)
      from = params[:from] || 1.month.ago
      to = params[:to] || 1.month.from_now
      @billings = scope.default_includes.
          where('bill_date >= ?', from).
          where('bill_date <= ?', to)

      @appointments = Appointment.where.not(id: Billing.pluck(:appointment_id))
    else
      @billings = scope.visible
    end
  end

  # GET /billings/1
  # GET /billings/1.json
  def show
  end

  # GET /billings/new
  def new
    @billing = Billing.new(user_id: User.current.id,
                           appointment_id: @appointment.id
    )
    set_breadcrumbs
  end

  # GET /billings/1/edit
  def edit
  end

  # POST /billings
  # POST /billings.json
  def create
    @billing = Billing.new(billing_params)
    @appointment = @billing.appointment
    respond_to do |format|
      if @billing.save
        format.html { redirect_to appointment_path(@appointment) + '#tabs-billing', notice: 'Billing was successfully created.' }
        format.json { render :show, status: :created, location: @billing }
      else
        format.html { render :new }
        format.json { render json: @billing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /billings/1
  # PATCH/PUT /billings/1.json
  def update
    respond_to do |format|
      if @billing.update(billing_params)
        format.html { redirect_to appointment_path(@appointment) + '#tabs-billing', notice: 'Billing was successfully updated.' }
        format.json { render :show, status: :ok, location: @billing }
      else
        format.html { render :edit }
        format.json { render json: @billing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /billings/1
  # DELETE /billings/1.json
  def destroy
    @billing.destroy
    respond_to do |format|
      format.html { redirect_to appointment_path(@appointment) + '#tabs-billing', notice: 'Billing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_billing
    @billing = Billing.find(params[:id])
    @appointment = @billing.appointment
    set_breadcrumbs
    add_breadcrumb @billing.to_s, @billing
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def set_breadcrumbs
    if @appointment.case
      add_breadcrumb 'Case Records', :cases_path
      add_breadcrumb @appointment.case, @appointment.case
      add_breadcrumb I18n.t(:appointments), case_path(@appointment.case) + '#tabs-appointments'
    else
      add_breadcrumb I18n.t(:appointments), :appointments_path
    end

    add_breadcrumb @appointment, appointment_path(@appointment)
    add_breadcrumb 'Billings', appointment_path(@appointment) + '#tabs-billing'
  end

  def set_appointment
   @appointment = Appointment.find(params[:appointment_id])
#   add_breadcrumb @appointment.to_s, @appointment
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def billing_params
    params.require(:billing).permit(Billing.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @billing.can?(:edit_billings, :manage_billings, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @billing.can?(:delete_billings, :manage_billings, :manage_roles)
  end
  
end
