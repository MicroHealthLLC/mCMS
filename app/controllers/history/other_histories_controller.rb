class OtherHistoriesController < UserHistoryController
  add_breadcrumb 'Socioeconomic History', '/socioeconomic_record'
  add_breadcrumb I18n.t(:other_histories), :other_histories_path
  before_action :set_other_history, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /other_histories
  # GET /other_histories.json
  def index
    respond_to do |format|
      format.html{  redirect_to  socioeconomic_record_path + "#tabs-other_history" }
     format.js{ render 'application/index' }
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = OtherHistoryDatatable.new(view_context, options).as_json
        send_data OtherHistory.to_csv(json[:data]), filename: "Other-history-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: OtherHistoryDatatable.new(view_context,options)
      }
    end
  end

  # GET /other_histories/1
  # GET /other_histories/1.json
  def show
  end

  # GET /other_histories/new
  def new
    @other_history = OtherHistory.new(user_id: User.current.id,
                                      date_identified: Date.today)
  end

  # GET /other_histories/1/edit
  def edit
  end

  # POST /other_histories
  # POST /other_histories.json
  def create
    @other_history = OtherHistory.new(other_history_params)

    respond_to do |format|
      if @other_history.save
        format.html { redirect_to other_histories_url, notice: 'OtherHistory was successfully created.' }
      #  format.json { render :show, status: :created, location: @other_history }
      else
        format.html { render :new }
        format.json { render json: @other_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /other_histories/1
  # PATCH/PUT /other_histories/1.json
  def update
    respond_to do |format|
      if @other_history.update(other_history_params)
        format.html { redirect_to other_histories_url, notice: 'OtherHistory was successfully updated.' }
      #  format.json { render :show, status: :ok, location: @other_history }
      else
        format.html { render :edit }
        format.json { render json: @other_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /other_histories/1
  # DELETE /other_histories/1.json
  def destroy
    @other_history.destroy
    respond_to do |format|
      format.html { redirect_to other_histories_url, notice: 'OtherHistory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_other_history
    @other_history = OtherHistory.find(params[:id])
    add_breadcrumb @other_history, @other_history
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def other_history_params
    params.require(:other_history).permit(OtherHistory.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @other_history.can?(:edit_other_histories, :manage_other_histories, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @other_history.can?(:delete_other_histories, :manage_other_histories, :manage_roles)
  end

end
