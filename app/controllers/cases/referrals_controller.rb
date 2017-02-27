class ReferralsController < UserCasesController
add_breadcrumb I18n.t(:referrals), :referrals_path
before_action :set_referral, only: [:show, :edit, :update, :destroy]

before_action :authorize_edit, only: [:edit, :update]
before_action :authorize_delete, only: [:destroy]


# GET /referrals
# GET /referrals.json
def index
  @referrals = Referral.visible
end

# GET /referrals/1
# GET /referrals/1.json
def show
end

# GET /referrals/new
def new
  @referral = Referral.new(user_id: User.current.id,
                                 case_id: params[:case_id])
end

# GET /referrals/1/edit
def edit
end

# POST /referrals
# POST /referrals.json
def create
  @referral = Referral.new(referral_params)

  respond_to do |format|
    if @referral.save
      format.html { redirect_to @referral, notice: 'Referral was successfully created.' }
      format.json { render :show, status: :created, location: @referral }
    else
      format.html { render :new }
      format.json { render json: @referral.errors, status: :unprocessable_entity }
    end
  end
end

# PATCH/PUT /referrals/1
# PATCH/PUT /referrals/1.json
def update
  respond_to do |format|
    if @referral.update(referral_params)
      format.html { redirect_to @referral, notice: 'Referral was successfully updated.' }
      format.json { render :show, status: :ok, location: @referral }
    else
      format.html { render :edit }
      format.json { render json: @referral.errors, status: :unprocessable_entity }
    end
  end
end

# DELETE /referrals/1
# DELETE /referrals/1.json
def destroy
  @referral.destroy
  respond_to do |format|
    format.html { redirect_to referrals_url, notice: 'Referral was successfully destroyed.' }
    format.json { head :no_content }
  end
end

private
# Use callbacks to share common setup or constraints between actions.
def set_referral
  @referral = Referral.find(params[:id])
  add_breadcrumb @referral.to_s, @referral
rescue ActiveRecord::RecordNotFound
  render_404
end

# Never trust parameters from the scary internet, only allow the white list through.
def referral_params
  params.require(:referral).permit(Referral.safe_attributes)
end

def authorize_edit
  raise Unauthorized unless @referral.can?(:edit_referrals, :manage_referrals, :manage_roles)
end

def authorize_delete
  raise Unauthorized unless @referral.can?(:delete_referrals, :manage_referrals, :manage_roles)
end
end

