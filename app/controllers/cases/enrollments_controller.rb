class EnrollmentsController < UserCasesController
  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /enrollments
  # GET /enrollments.json
  def index
    add_breadcrumb I18n.t('enrollments'), :enrollments_path
    options = Hash.new
    options[:status_type] = params[:status_type]
    options[:case_id] = params[:case_id]
    options[:appointment_id] = params[:appointment_id]
    if params[:case_id]
      @case = Case.find params[:case_id]
    end
    if params[:appointment_id]
      @appointment = Appointment.find params[:appointment_id]
    end
    respond_to do |format|
      format.html{ }
      format.js{ render 'application/index' }
      format.pdf{}
      format.csv{ params[:length] = 500
      options[:show_case] = 'true'
      json = EnrollmentDatatable.new(view_context, options).as_json
      send_data Enrollment.to_csv(json[:data]), filename: "Enrollment-#{Date.today}.csv"
      }
      format.json{

        render json: EnrollmentDatatable.new(view_context,options)
      }
    end
  end

  # GET /enrollments/1
  # GET /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new(user_id: User.current.id,
                                 date_start: Date.today,
                                 case_id: params[:case_id])

    @case = @enrollment.case
    if  @case
      add_breadcrumb @case,  @case
      add_breadcrumb I18n.t('enrollments'), case_path(@case) + '#tabs-enrollments'
    else
      add_breadcrumb I18n.t('enrollments'), :enrollments_path
    end
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments
  # POST /enrollments.json
  def create
    @enrollment = Enrollment.new(enrollment_params)

    respond_to do |format|
      if @enrollment.save
        set_link_to_appointment(@enrollment)
        format.html { redirect_to back_index_case_url, notice: 'Enrollment was successfully created.' }
      #  format.json { render :show, status: :created, location: @enrollment }
      else
        format.html { render :new }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to back_index_case_url, notice: 'Enrollment was successfully updated.' }
      #  format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.json
  def destroy
    @enrollment.destroy
    respond_to do |format|
      format.html { redirect_to back_index_case_url, notice: 'Enrollment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_enrollment
    @enrollment = Enrollment.includes(:user).find(params[:id])
    @case = @enrollment.case
    if  @case
      add_breadcrumb @case,  @case
      add_breadcrumb I18n.t('enrollments'), case_path(@case) + '#tabs-enrollments'
    else
      add_breadcrumb I18n.t('enrollments'), :enrollments_path
    end

    add_breadcrumb @enrollment.to_s, @enrollment
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def enrollment_params
    params.require(:enrollment).permit(Enrollment.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @enrollment.can?(:edit_enrollments, :manage_enrollments, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @enrollment.can?(:delete_enrollments, :manage_enrollments, :manage_roles)
  end
end
