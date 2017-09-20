class HousingsController < UserHistoryController

  add_breadcrumb I18n.t(:housings), :housings_path
  before_action :set_housing, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /housings
  # GET /housings.json
  def index
    redirect_to socioeconomic_record_path if request.format.to_sym == :html
    scope = Housing.visible
    scope = case params[:status_type]
              when 'all' then scope.all_data
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.all_data
            end

    @housings = scope
  end

  # GET /housings/1
  # GET /housings/1.json
  def show
  end

  # GET /housings/new
  def new
    @housing = Housing.new(user_id: User.current.id,
                           date_start: Date.today)
  end

  # GET /housings/1/edit
  def edit
  end

  # POST /housings
  # POST /housings.json
  def create
    @housing = Housing.new(housing_params)

    respond_to do |format|
      if @housing.save
        format.html { redirect_to @housing, notice: 'Housing was successfully created.' }
        format.json { render :show, status: :created, location: @housing }
      else
        format.html { render :new }
        format.json { render json: @housing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /housings/1
  # PATCH/PUT /housings/1.json
  def update
    respond_to do |format|
      if @housing.update(housing_params)
        format.html { redirect_to @housing, notice: 'Housing was successfully updated.' }
        format.json { render :show, status: :ok, location: @housing }
      else
        format.html { render :edit }
        format.json { render json: @housing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /housings/1
  # DELETE /housings/1.json
  def destroy
    @housing.destroy
    respond_to do |format|
      format.html { redirect_to housings_url, notice: 'Housing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_housing
    @housing = Housing.find(params[:id])
    add_breadcrumb @housing, @housing
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def housing_params
    params.require(:housing).permit(Housing.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @housing.can?(:edit_housings, :manage_housings, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @housing.can?(:delete_housings, :manage_housings, :manage_roles)
  end
end
