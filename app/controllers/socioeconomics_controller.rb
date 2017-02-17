class SocioeconomicsController < ApplicationController
  before_action :set_socioeconomic, only: [:show, :edit, :update, :destroy]

  # GET /socioeconomics
  # GET /socioeconomics.json
  def index
    @socioeconomics = Socioeconomic.all
  end

  # GET /socioeconomics/1
  # GET /socioeconomics/1.json
  def show
  end

  # GET /socioeconomics/new
  def new
    @socioeconomic = Socioeconomic.new
  end

  # GET /socioeconomics/1/edit
  def edit
  end

  # POST /socioeconomics
  # POST /socioeconomics.json
  def create
    @socioeconomic = Socioeconomic.new(socioeconomic_params)

    respond_to do |format|
      if @socioeconomic.save
        format.html { redirect_to @socioeconomic, notice: 'Socioeconomic was successfully created.' }
        format.json { render :show, status: :created, location: @socioeconomic }
      else
        format.html { render :new }
        format.json { render json: @socioeconomic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /socioeconomics/1
  # PATCH/PUT /socioeconomics/1.json
  def update
    respond_to do |format|
      if @socioeconomic.update(socioeconomic_params)
        format.html { redirect_to @socioeconomic, notice: 'Socioeconomic was successfully updated.' }
        format.json { render :show, status: :ok, location: @socioeconomic }
      else
        format.html { render :edit }
        format.json { render json: @socioeconomic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /socioeconomics/1
  # DELETE /socioeconomics/1.json
  def destroy
    @socioeconomic.destroy
    respond_to do |format|
      format.html { redirect_to socioeconomics_url, notice: 'Socioeconomic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_socioeconomic
      @socioeconomic = Socioeconomic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def socioeconomic_params
      params.require(:socioeconomic).permit(:user_id, :icdcm_code_id, :date_identified, :date_resolved, :socioeconomic_status_id, :socioeconomic_type_id, :description)
    end
end
