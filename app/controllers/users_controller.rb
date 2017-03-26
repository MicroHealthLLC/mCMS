class UsersController < ProtectForgeryApplication
  before_action  :authenticate_user!
  before_action :find_user, except: [:restore, :index, :new, :create, :recently_connected]

  before_filter :require_admin, only: [:destroy]
  def index
    respond_to do |format|
      format.html{}
      format.json{
        options = Hash.new
        render json: UserDatatable.new(view_context,options)
      }
    end
  end

  def recently_connected
    respond_to do |format|
      format.js{
        @recently_connected = User.
            recently_active.
            includes(:core_demographic).
            where.not(id: current_user.id )
      }
    end
  end

  def restore
    u = User.unscoped.find params[:id]
    u.restore
    u.save
    flash[:notice] = 'User restored'
    redirect_to :back
  end

  def lock
    u = User.unscoped.find params[:id]
    u.failed_attempts = Setting['maximum_attempts'].to_i
    u.locked_at = Time.now
    u.save
    flash[:notice] = 'User locked'
    redirect_to :back
  end

  def unlock
    u = User.unscoped.find params[:id]
    u.failed_attempts = 0
    u.locked_at = nil
    u.save
    flash[:notice] = 'User unlocked'
    redirect_to :back
  end

  def search_users
    q = params[:q]
    respond_to do |format|
      format.js{
        @recently_connected = User.
            where('login like ? OR email like ?', "#{q}%",  "#{q}%").
            includes(:core_demographic).
            where.not(id: current_user.id )
      }
    end
  end

  def show
    @profile       = @user.profile
    @educations    = @user.educations
    @documents     = @user.documents
    @organizations = @user.organizations
  end


  def change_password
    if params[:user][:password] == params[:user][:password_confirmation]
      if @user.update(password: params[:user][:password])
        flash[:notice] = I18n.t('devise.passwords.updated_not_active')
      else
        flash[:notice] = I18n.t('error_update')
      end

    else
      flash[:error] = 'Password not matched'
    end
    redirect_to user_path(@user)
  end

  def attachments
    @user.update(params.require(:user).permit(user_attachments_attributes: [Attachment.safe_attributes]))
    @user.save
    redirect_to user_path(@user)
  end

  def change_basic_info
    if @user.update(params.require(:user).permit(User.safe_attributes + [:admin]))
      flash[:notice] = I18n.t('notice_successful_update')
    else
      flash[:error] = I18n.t('error_update')
    end
    redirect_to user_path(@user)
  end

  def image_upload
    @user.avatar = params[:images]
    @user.save
    render 'uploader/image_upload'
  end

  def remove_image
    @user.remove_avatar!
    @user.save
    render 'uploader/remove_image'
  end

  def destroy
    @user.destroy
    flash[:notice] = I18n.t('notice_successful_delete')
    redirect_to :back
  end

  private

  def find_user
    @user = User.find params[:id]
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
