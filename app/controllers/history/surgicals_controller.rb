class SurgicalsController < UserHistoryController
  add_breadcrumb I18n.t(:surgicals), :surgicals_path
  before_action :set_surgical, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /surgicals
  # GET /surgicals.json
  def index
    respond_to do |format|
      format.html{  redirect_to medical_record_path }
      format.js{}
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = SurgeryDatatable.new(view_context, options).as_json
        send_data Surgical.to_csv(json[:data]), filename: "surgical-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: SurgeryDatatable.new(view_context,options)
      }
    end
  end

  # GET /surgicals/1
  # GET /surgicals/1.json
  def show
  end

  # GET /surgicals/new
  def new
    @surgical = Surgical.new(user_id: User.current.id)
  end

  # GET /surgicals/1/edit
  def edit
  end

  # POST /surgicals
  # POST /surgicals.json
  def create
    @surgical = Surgical.new(surgical_params)

    respond_to do |format|
      if @surgical.save
        format.html { redirect_to @surgical, notice: 'Surgical was successfully created.' }
        format.json { render :show, status: :created, location: @surgical }
      else
        format.html { render :new }
        format.json { render json: @surgical.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surgicals/1
  # PATCH/PUT /surgicals/1.json
  def update
    respond_to do |format|
      if @surgical.update(surgical_params)
        format.html { redirect_to @surgical, notice: 'Surgical was successfully updated.' }
        format.json { render :show, status: :ok, location: @surgical }
      else
        format.html { render :edit }
        format.json { render json: @surgical.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surgicals/1
  # DELETE /surgicals/1.json
  def destroy
    @surgical.destroy
    respond_to do |format|
      format.html { redirect_to surgicals_url, notice: 'Surgical was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_surgical
    @surgical = Surgical.find(params[:id])
    add_breadcrumb @surgical, @surgical
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def surgical_params
    params.require(:surgical).permit(Surgical.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @surgical.can?(:edit_surgicals, :manage_surgicals, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @surgical.can?(:delete_surgicals, :manage_surgicals, :manage_roles)
  end

end