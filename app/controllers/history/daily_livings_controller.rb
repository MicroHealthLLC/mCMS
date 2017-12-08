class DailyLivingsController < UserHistoryController
  add_breadcrumb I18n.t(:daily_livings), :daily_livings_path
  before_action :set_daily_living, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /daily_livings
  # GET /daily_livings.json
  def index
    respond_to do |format|
      format.html{  redirect_to  socioeconomic_record_path }
      format.js{}
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = DailyLivingDatatable.new(view_context, options).as_json
        send_data DailyLiving.to_csv(json[:data]), filename: "Daily-livings-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: DailyLivingDatatable.new(view_context,options)
      }
    end
  end

  # GET /daily_livings/1
  # GET /daily_livings/1.json
  def show
  end

  # GET /daily_livings/new
  def new
    @daily_living = DailyLiving.new(user_id: User.current.id,
                                    date_start: Date.today)
  end

  # GET /daily_livings/1/edit
  def edit
  end

  # POST /daily_livings
  # POST /daily_livings.json
  def create
    @daily_living = DailyLiving.new(daily_living_params)

    respond_to do |format|
      if @daily_living.save
        format.html { redirect_to @daily_living, notice: 'Daily living was successfully created.' }
        format.json { render :show, status: :created, location: @daily_living }
      else
        format.html { render :new }
        format.json { render json: @daily_living.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_livings/1
  # PATCH/PUT /daily_livings/1.json
  def update
    respond_to do |format|
      if @daily_living.update(daily_living_params)
        format.html { redirect_to @daily_living, notice: 'Daily living was successfully updated.' }
        format.json { render :show, status: :ok, location: @daily_living }
      else
        format.html { render :edit }
        format.json { render json: @daily_living.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_livings/1
  # DELETE /daily_livings/1.json
  def destroy
    @daily_living.destroy
    respond_to do |format|
      format.html { redirect_to daily_livings_url, notice: 'Daily living was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_daily_living
    @daily_living = DailyLiving.find(params[:id])
    add_breadcrumb @daily_living, @daily_living
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def daily_living_params
    params.require(:daily_living).permit(DailyLiving.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @daily_living.can?(:edit_daily_livings, :manage_daily_livings, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @daily_living.can?(:delete_daily_livings, :manage_daily_livings, :manage_roles)
  end

end
