class JobsController < UserProfilesController
  before_action :set_job_app
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


# GET /job
# GET /job.json
  def index
    @job = Job.for_status params[:status_type]
  end

# GET /job/1
# GET /job/1.json
  def show
  end

# GET /job/new
  def new
    @job = Job.new(user_id: User.current.id, job_app_id: @job_app.id)
  end

# GET /job/1/edit
  def edit
  end

# POST /job
# POST /job.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job_app, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

# PATCH/PUT /job/1
# PATCH/PUT /job/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job_app, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

# DELETE /job/1
# DELETE /job/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to @job_app, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
    add_breadcrumb @job, job_app_job_url(@job_app, @job)
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def set_job_app
    @job_app = JobApp.find(params[:job_app_id])
    add_breadcrumb @job_app, @job_app
  rescue ActiveRecord::RecordNotFound
    render_404
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def job_params
    params.require(:job).permit(Job.safe_attributes)
  end

  def authorize_show
    raise Unauthorized unless @job.can?(:view_job, :manage_job, :manage_roles)
  end

  def authorize_edit
    raise Unauthorized unless @job.can?(:edit_job, :manage_job, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @job.can?(:delete_job, :manage_job, :manage_roles)
  end
end
