class OtherHistoriesController < ApplicationController
  before_action :set_other_history, only: [:show, :edit, :update, :destroy]

  # GET /other_histories
  # GET /other_histories.json
  def index
    @other_histories = OtherHistory.all
  end

  # GET /other_histories/1
  # GET /other_histories/1.json
  def show
  end

  # GET /other_histories/new
  def new
    @other_history = OtherHistory.new
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
        format.html { redirect_to @other_history, notice: 'Other history was successfully created.' }
        format.json { render :show, status: :created, location: @other_history }
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
        format.html { redirect_to @other_history, notice: 'Other history was successfully updated.' }
        format.json { render :show, status: :ok, location: @other_history }
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
      format.html { redirect_to other_histories_url, notice: 'Other history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_other_history
      @other_history = OtherHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def other_history_params
      params.require(:other_history).permit(:user_id, :icdcm_code_id, :date_identified, :date_resolved, :other_history_status_id, :other_history_type_id, :description)
    end
end
