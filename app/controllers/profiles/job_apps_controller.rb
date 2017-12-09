class JobAppsController < UserProfilesController
  add_breadcrumb I18n.t(:job_apps), :job_apps_path
  before_action :set_job_app, only: [:show, :edit, :update, :destroy]
# before_action :find_optional_user


  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


# GET /job_apps
# GET /job_apps.json
  def index
    respond_to do |format|
      format.html{  redirect_to occupational_record_path }
      format.js{}
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = JobAppDatatable.new(view_context, options).as_json
        send_data JobApp.to_csv(json[:data]), filename: "JobApp-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: JobAppDatatable.new(view_context,options)
      }
    end
  end

# GET /job_apps/1
# GET /job_apps/1.json
  def show
    @jobs = @job_app.jobs
  end

# GET /job_apps/new
  def new
    @job_app = JobApp.new(user_id: User.current.id)
  end

# GET /job_apps/1/edit
  def edit
  end

# POST /job_apps
# POST /job_apps.json
  def create
    @job_app = JobApp.new(job_app_params)

    respond_to do |format|
      if @job_app.save
        format.html { redirect_to job_apps_url, notice: 'JobApp was successfully created.' }
        format.json { render :show, status: :created, location: @job_app }
      else
        format.html { render :new }
        format.json { render json: @job_app.errors, status: :unprocessable_entity }
      end
    end
  end

# PATCH/PUT /job_apps/1
# PATCH/PUT /job_apps/1.json
  def update
    respond_to do |format|
      if @job_app.update(job_app_params)
        format.html { redirect_to job_apps_url, notice: 'JobApp was successfully updated.' }
        format.json { render :show, status: :ok, location: @job_app }
      else
        format.html { render :edit }
        format.json { render json: @job_app.errors, status: :unprocessable_entity }
      end
    end
  end

# DELETE /job_apps/1
# DELETE /job_apps/1.json
  def destroy
    @job_app.destroy
    respond_to do |format|
      format.html { redirect_to job_apps_url, notice: 'JobApp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_job_app
    @job_app = JobApp.find(params[:id])
    add_breadcrumb @job_app, @job_app
  rescue ActiveRecord::RecordNotFound
    render_404
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def job_app_params
    params.require(:job_app).permit(JobApp.safe_attributes)
  end

  def authorize_show
    raise Unauthorized unless @job_app.can?(:view_job_apps, :manage_job_apps, :manage_roles)
  end

  def authorize_edit
    raise Unauthorized unless @job_app.can?(:edit_job_apps, :manage_job_apps, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @job_app.can?(:delete_job_apps, :manage_job_apps, :manage_roles)
  end
end
