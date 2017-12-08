class LegalsController < UserHistoryController
  add_breadcrumb I18n.t(:legals), :legals_path
  before_action :set_legal, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /legals
  # GET /legals.json
  def index
    respond_to do |format|
      format.html{  redirect_to  socioeconomic_record_path }
      format.js{}
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = LegalDatatable.new(view_context, options).as_json
        send_data Legal.to_csv(json[:data]), filename: "Legal-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: LegalDatatable.new(view_context,options)
      }
    end
  end

  # GET /legals/1
  # GET /legals/1.json
  def show
  end

  # GET /legals/new
  def new
    @legal = Legal.new(user_id: User.current.id,
                       date_start: Date.today)
  end

  # GET /legals/1/edit
  def edit
  end

  # POST /legals
  # POST /legals.json
  def create
    @legal = Legal.new(legal_params)

    respond_to do |format|
      if @legal.save
        format.html { redirect_to @legal, notice: 'Legal was successfully created.' }
        format.json { render :show, status: :created, location: @legal }
      else
        format.html { render :new }
        format.json { render json: @legal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /legals/1
  # PATCH/PUT /legals/1.json
  def update
    respond_to do |format|
      if @legal.update(legal_params)
        format.html { redirect_to @legal, notice: 'Legal was successfully updated.' }
        format.json { render :show, status: :ok, location: @legal }
      else
        format.html { render :edit }
        format.json { render json: @legal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /legals/1
  # DELETE /legals/1.json
  def destroy
    @legal.destroy
    respond_to do |format|
      format.html { redirect_to legals_url, notice: 'Legal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_legal
    @legal = Legal.find(params[:id])
    add_breadcrumb @legal, @legal
  rescue ActiveRecord::RecordNotFound
    render_404
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def legal_params
    params.require(:legal).permit(Legal.safe_attributes)
  end


  def authorize_edit
    raise Unauthorized unless @legal.can?(:edit_legals, :manage_legals, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @legal.can?(:delete_legals, :manage_legals, :manage_roles)
  end
end
