class FinancialsController < UserHistoryController
  add_breadcrumb 'Socioeconomic History', '/socioeconomic_record'

  add_breadcrumb I18n.t(:financials), :financials_path
  before_action :set_financial, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]
  # GET /financials
  # GET /financials.json
  def index
    respond_to do |format|
      format.html{  redirect_to  socioeconomic_record_path + "#tabs-financial" }
     format.js{ render 'application/index' }
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = FinancialDatatable.new(view_context, options).as_json
        send_data Financial.to_csv(json[:data]), filename: "Financial-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: FinancialDatatable.new(view_context,options)
      }
    end
  end

  # GET /financials/1
  # GET /financials/1.json
  def show
  end

  # GET /financials/new
  def new
    @financial = Financial.new(user_id: User.current.id,
                               date_start: Date.today)
  end

  # GET /financials/1/edit
  def edit
  end

  # POST /financials
  # POST /financials.json
  def create
    @financial = Financial.new(financial_params)

    respond_to do |format|
      if @financial.save
        format.html { redirect_to financials_url, notice: 'Financial was successfully created.' }
      #  format.json { render :show, status: :created, location: @financial }
      else
        format.html { render :new }
        format.json { render json: @financial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /financials/1
  # PATCH/PUT /financials/1.json
  def update
    respond_to do |format|
      if @financial.update(financial_params)
        format.html { redirect_to financials_url, notice: 'Financial was successfully updated.' }
      #  format.json { render :show, status: :ok, location: @financial }
      else
        format.html { render :edit }
        format.json { render json: @financial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /financials/1
  # DELETE /financials/1.json
  def destroy
    @financial.destroy
    respond_to do |format|
      format.html { redirect_to financials_url, notice: 'Financial was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_financial
      @financial = Financial.find(params[:id])
      add_breadcrumb @financial, @financial
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def financial_params
      params.require(:financial).permit(Financial.safe_attributes)
    end

  def authorize_edit
    raise Unauthorized unless @financial.can?(:edit_financials, :manage_financials, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @financial.can?(:delete_financials, :manage_financials, :manage_roles)
  end
end
