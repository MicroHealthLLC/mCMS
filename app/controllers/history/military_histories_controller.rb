class MilitaryHistoriesController < UserHistoryController
  add_breadcrumb 'Occupational History', '/occupational_record'
  add_breadcrumb I18n.t(:military_histories), :military_histories_path
  before_action :set_military_history, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /military_histories
  # GET /military_histories.json
  def index
    respond_to do |format|
      format.html{  redirect_to occupational_record_path  + "#tabs-military_history"}
     format.js{ render 'application/index' }
      format.pdf{}
      format.csv{
        params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = MilitaryHistoryDatatable.new(view_context, options).as_json
        send_data MilitaryHistory.to_csv(json[:data]), filename: "MilitaryHistory-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: MilitaryHistoryDatatable.new(view_context,options)
      }
    end
  end

  # GET /military_histories/1
  # GET /military_histories/1.json
  def show
  end

  # GET /military_histories/new
  def new
    @military_history = MilitaryHistory.new(user_id: User.current.id,
                                            date_started: Date.today)
  end

  # GET /military_histories/1/edit
  def edit
  end

  # POST /military_histories
  # POST /military_histories.json
  def create
    @military_history = MilitaryHistory.new(military_history_params)

    respond_to do |format|
      if @military_history.save
        format.html { redirect_to military_histories_url, notice: 'Military history was successfully created.' }
      #  format.json { render :show, status: :created, location: @military_history }
      else
        format.html { render :new }
        format.json { render json: @military_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /military_histories/1
  # PATCH/PUT /military_histories/1.json
  def update
    respond_to do |format|
      if @military_history.update(military_history_params)
        format.html { redirect_to military_histories_url, notice: 'Military history was successfully updated.' }
      #  format.json { render :show, status: :ok, location: @military_history }
      else
        format.html { render :edit }
        format.json { render json: @military_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /military_histories/1
  # DELETE /military_histories/1.json
  def destroy
    @military_history.destroy
    respond_to do |format|
      format.html { redirect_to military_histories_url, notice: 'Military history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_military_history
    @military_history = MilitaryHistory.find(params[:id])
    add_breadcrumb @military_history, @military_history

  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def military_history_params
    params.require(:military_history).permit(MilitaryHistory.safe_attributes)
  end


  def authorize_edit
    raise Unauthorized unless @military_history.can?(:edit_military_histories, :manage_military_histories, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @military_history.can?(:delete_military_histories, :manage_military_histories, :manage_roles)
  end
end
