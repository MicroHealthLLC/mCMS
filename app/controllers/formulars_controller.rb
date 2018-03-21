class FormularsController < ProtectForgeryApplication
  before_action  :authenticate_user!
  before_action :set_formular, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: [:show]

  # GET /formulars
  # GET /formulars.json
  def index
    respond_to do |format|
      format.html{
        @formulars = Formular.include_enumerations.filter_status(params[:status_type])
      }
      format.js{ render 'application/index' }
      format.pdf{}
    end
  end

  # GET /formulars/1
  # GET /formulars/1.json
  def show
    @details = @formular.form_details.
        includes(:form_results).
        references(:form_results)
  end

  # GET /formulars/new
  def new
    @formular = Formular.new
  end

  # GET /formulars/1/edit
  def edit
  end

  # POST /formulars
  # POST /formulars.json
  def create
    @formular = Formular.new(formular_params)
    respond_to do |format|
      if @formular.save
        format.html { redirect_to formulars_path, notice: 'Formular was successfully created.' }
        format.json { render :show, status: :created, location: @formular }
      else
        format.html { render :new }
        format.json { render json: @formular.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /formulars/1
  # PATCH/PUT /formulars/1.json
  def update
    respond_to do |format|
      if @formular.update(formular_params)
        format.html { redirect_to formulars_path, notice: 'Formular was successfully updated.' }
        format.json { render :show, status: :ok, location: @formular }
      else
        format.html { render :edit }
        format.json { render json: @formular.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /formulars/1
  # DELETE /formulars/1.json
  def destroy
    @formular.destroy
    respond_to do |format|
      format.html { redirect_to formulars_url, notice: 'Formular was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_formular
      @formular = Formular.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def formular_params
      params.require(:formular).permit(Formular.safe_attributes)
    end

  def authorize
    render_403 unless User.current.can?(:manage_roles)
  end
end
