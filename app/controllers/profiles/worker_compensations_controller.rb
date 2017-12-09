class WorkerCompensationsController < UserProfilesController
  add_breadcrumb I18n.t(:worker_compensations), :worker_compensations_path
  before_action :set_worker_compensation, only: [:show, :edit, :update, :destroy]
# before_action :find_optional_user


  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


# GET /worker_compensations
# GET /worker_compensations.json
  def index
    respond_to do |format|
      format.html{  redirect_to occupational_record_path }
      format.js{}
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = WorkerCompensationDatatable.new(view_context, options).as_json
        send_data WorkerCompensation.to_csv(json[:data]), filename: "WorkerCompensation-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: WorkerCompensationDatatable.new(view_context,options)
      }
    end
  end

# GET /worker_compensations/1
# GET /worker_compensations/1.json
  def show
  end

# GET /worker_compensations/new
  def new
    @worker_compensation = WorkerCompensation.new(user_id: User.current.id)
  end

# GET /worker_compensations/1/edit
  def edit
  end

# POST /worker_compensations
# POST /worker_compensations.json
  def create
    @worker_compensation = WorkerCompensation.new(worker_compensation_params)

    respond_to do |format|
      if @worker_compensation.save
        format.html { redirect_to worker_compensations_url, notice: 'WorkerCompensation was successfully created.' }
        format.json { render :show, status: :created, location: @worker_compensation }
      else
        format.html { render :new }
        format.json { render json: @worker_compensation.errors, status: :unprocessable_entity }
      end
    end
  end

# PATCH/PUT /worker_compensations/1
# PATCH/PUT /worker_compensations/1.json
  def update
    respond_to do |format|
      if @worker_compensation.update(worker_compensation_params)
        format.html { redirect_to worker_compensations_url, notice: 'WorkerCompensation was successfully updated.' }
        format.json { render :show, status: :ok, location: @worker_compensation }
      else
        format.html { render :edit }
        format.json { render json: @worker_compensation.errors, status: :unprocessable_entity }
      end
    end
  end

# DELETE /worker_compensations/1
# DELETE /worker_compensations/1.json
  def destroy
    @worker_compensation.destroy
    respond_to do |format|
      format.html { redirect_to worker_compensations_url, notice: 'WorkerCompensation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_worker_compensation
    @worker_compensation = WorkerCompensation.find(params[:id])
    add_breadcrumb @worker_compensation, @worker_compensation
  rescue ActiveRecord::RecordNotFound
    render_404
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def worker_compensation_params
    params.require(:worker_compensation).permit(WorkerCompensation.safe_attributes)
  end

  def authorize_show
    raise Unauthorized unless @worker_compensation.can?(:view_worker_compensations, :manage_worker_compensations, :manage_roles)
  end

  def authorize_edit
    raise Unauthorized unless @worker_compensation.can?(:edit_worker_compensations, :manage_worker_compensations, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @worker_compensation.can?(:delete_worker_compensations, :manage_worker_compensations, :manage_roles)
  end
end
