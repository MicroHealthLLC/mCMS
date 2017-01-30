class EmployeesController < ApplicationController
  before_action  :authenticate_user!
  before_action  :set_employee, :only => [:show, :destroy, :log_in, :update]
  before_action  :authorize

  def index
    respond_to do |format|
      format.html{}
      format.json{
        options = Hash.new
        render json: EmployeeDatatable.new(view_context,options)
      }
    end
  end

  def show

  end

  def new
    r = Role.where(role_type_id: RoleType.default.try(:id)).first
    @user = User.new(state: true, role_id: r.try(:id))
    @user.core_demographic = CoreDemographic.new
  end

  def create
    @user = User.new(params.require(:user).permit(employee_params))
    if @user.save
      UserMailer.welcome_email(@user, params[:user][:password]).deliver_later
      redirect_to users_url
    else
      render 'new'
    end
  end

  def update
    if @employee.update(params.require(:user).permit(User.safe_attributes))
      flash[:notice] = I18n.t('notice_successful_update')
    else
      flash[:error] = I18n.t('error_update')
    end
    redirect_to employee_path(@employee)
  end

  def log_in
    session[:employee_id] = @employee.id
    # flash[:notice]= "Logged In from #{@employee.login}"
    redirect_to employee_path(@employee)
  end

  def destroy
    session[:employee_id] = nil
    flash[:notice]= "Logged Off from #{@employee.login}"
    redirect_to root_path
  end

  private

  def set_employee
    @employee = User.find params[:id]
    raise Unauthorized if @employee.admin? and !User.current.admin?
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def authorize
    raise Unauthorized unless User.current_user.allowed_to?(:manage_roles)
  end

  def employee_params
    User.current.admin? ? User.admin_safe_attributes :  User.safe_attributes_with_password
  end
end
