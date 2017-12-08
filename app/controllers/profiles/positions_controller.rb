class PositionsController < UserProfilesController
  add_breadcrumb I18n.t(:positions), :positions_path
  before_action :set_position, only: [:show, :edit, :update, :destroy]
  # before_action :find_optional_user


  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /positions
  # GET /positions.json
  def index
    respond_to do |format|
      format.html{  redirect_to occupational_record_path }
      format.js{}
      format.pdf{}
      format.csv{
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = EducationDatatable.new(view_context, options).as_json
        send_data Education.to_csv(json[:data]), filename: "Education-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: EducationDatatable.new(view_context,options)
      }
    end
  end

  # GET /positions/1
  # GET /positions/1.json
  def show
  end

  # GET /positions/new
  def new
    @position = Position.new(user_id: User.current.id,
                             date_start: Date.today)
  end

  # GET /positions/1/edit
  def edit
  end

  # POST /positions
  # POST /positions.json
  def create
    @position = Position.new(position_params)

    respond_to do |format|
      if @position.save
        format.html { redirect_to positions_url, notice: 'Position was successfully created.' }
        format.json { render :show, status: :created, location: @position }
      else
        format.html { render :new }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /positions/1
  # PATCH/PUT /positions/1.json
  def update
    respond_to do |format|
      if @position.update(position_params)
        format.html { redirect_to positions_url, notice: 'Position was successfully updated.' }
        format.json { render :show, status: :ok, location: @position }
      else
        format.html { render :edit }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /positions/1
  # DELETE /positions/1.json
  def destroy
    @position.destroy
    respond_to do |format|
      format.html { redirect_to positions_url, notice: 'Position was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_position
    @position = Position.find(params[:id])
    add_breadcrumb @position, @position
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def position_params
    params.require(:position).permit(Position.safe_attributes)
  end

  def authorize_show
    raise Unauthorized unless @position.can?(:view_positions, :manage_positions, :manage_roles)
  end

  def authorize_edit
    raise Unauthorized unless @position.can?(:edit_positions, :manage_positions, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @position.can?(:delete_positions, :manage_positions, :manage_roles)
  end
end
