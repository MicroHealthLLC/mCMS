class JobApplicationsController < UserProfilesController
  add_breadcrumb I18n.t(:job_applications), :job_applications_path
  before_action :set_job_application, only: [:show, :edit, :update, :destroy]
# before_action :find_optional_user


  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


# GET /job_applications
# GET /job_applications.json
  def index
    @job_applications = JobApplication.visible
  end

# GET /job_applications/1
# GET /job_applications/1.json
  def show
  end

# GET /job_applications/new
  def new
    @job_application = JobApplication.new(user_id: User.current.id)
  end

# GET /job_applications/1/edit
  def edit
  end

# POST /job_applications
# POST /job_applications.json
  def create
    @job_application = JobApplication.new(job_application_params)

    respond_to do |format|
      if @job_application.save
        format.html { redirect_to job_applications_url, notice: 'JobApplication was successfully created.' }
        format.json { render :show, status: :created, location: @job_application }
      else
        format.html { render :new }
        format.json { render json: @job_application.errors, status: :unprocessable_entity }
      end
    end
  end

# PATCH/PUT /job_applications/1
# PATCH/PUT /job_applications/1.json
  def update
    respond_to do |format|
      if @job_application.update(job_application_params)
        format.html { redirect_to job_applications_url, notice: 'JobApplication was successfully updated.' }
        format.json { render :show, status: :ok, location: @job_application }
      else
        format.html { render :edit }
        format.json { render json: @job_application.errors, status: :unprocessable_entity }
      end
    end
  end

# DELETE /job_applications/1
# DELETE /job_applications/1.json
  def destroy
    @job_application.destroy
    respond_to do |format|
      format.html { redirect_to job_applications_url, notice: 'JobApplication was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_job_application
    @job_application = JobApplication.find(params[:id])
    add_breadcrumb @job_application, @job_application
  rescue ActiveRecord::RecordNotFound
    render_404
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def job_application_params
    params.require(:job_application).permit(JobApplication.safe_attributes)
  end

  def authorize_show
    raise Unauthorized unless @job_application.can?(:view_job_applications, :manage_job_applications, :manage_roles)
  end

  def authorize_edit
    raise Unauthorized unless @job_application.can?(:edit_job_applications, :manage_job_applications, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @job_application.can?(:delete_job_applications, :manage_job_applications, :manage_roles)
  end
end
