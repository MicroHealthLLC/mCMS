class UserInsurancesController < UserProfilesController
  add_breadcrumb 'Client Profile', '/profile_record'
  add_breadcrumb I18n.t(:insurance_plural), :user_insurances_path
  before_action :set_user_insurance, only: [:show, :edit, :update, :destroy]
  # before_action :find_optional_user

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /user_insurances
  # GET /user_insurances.json
  def index
    respond_to do |format|
      format.html{  redirect_to  profile_record_path + "#tabs-user_insurance" }
     format.js{ render 'application/index' }
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = UserInsuranceDatatable.new(view_context, options).as_json
        send_data UserInsurance.to_csv(json[:data]), filename: "UserInsurance-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: UserInsuranceDatatable.new(view_context,options)
      }
    end
  end

  # GET /user_insurances/1
  # GET /user_insurances/1.json
  def show
  end

  # GET /user_insurances/new
  def new
    @user_insurance = UserInsurance.new(user_id: User.current.id)
  end

  # GET /user_insurances/1/edit
  def edit
  end

  # POST /user_insurances
  # POST /user_insurances.json
  def create
    @user_insurance = UserInsurance.new(user_insurance_params)

    respond_to do |format|
      if @user_insurance.save
        format.html { redirect_to user_insurances_url, notice: 'Insurance was successfully created.' }
      #  format.json { render :show, status: :created, location: @user_insurance }
      else
        format.html { render :new }
      #  format.json { render json: @user_insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_insurances/1
  # PATCH/PUT /user_insurances/1.json
  def update
    respond_to do |format|
      if @user_insurance.update(user_insurance_params)
        format.html { redirect_to user_insurances_url, notice: 'Insurance was successfully updated.' }
      #  format.json { render :show, status: :ok, location: @user_insurance }
      else
        format.html { render :edit }
      #  format.json { render json: @user_insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_insurances/1
  # DELETE /user_insurances/1.json
  def destroy
    @user_insurance.destroy
    respond_to do |format|
      format.html { redirect_to user_insurances_url, notice: 'User insurance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user_insurance
    @user_insurance = UserInsurance.find(params[:id])
    add_breadcrumb @user_insurance, @user_insurance
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_insurance_params
    params.require(:user_insurance).permit(UserInsurance.safe_attributes)
  end

  def authorize_show
    raise Unauthorized unless @user_insurance.can?(:view_insurances, :manage_insurances, :manage_roles)
  end

  def authorize_edit
    raise Unauthorized unless @user_insurance.can?(:edit_insurances, :manage_insurances, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @user_insurance.can?(:delete_insurances, :manage_insurances, :manage_roles)
  end
end
