class ContactsController < UserProfilesController
  add_breadcrumb I18n.t(:contacts), :contacts_path
  before_action :set_contact, only: [:remove, :show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:remove, :edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    scope = Contact.visible
        scope = case params[:status_type]
                  when 'all' then scope.all_data
                  when 'opened' then scope.opened
                  when 'closed' then scope.closed
                  when 'flagged' then scope.flagged
                  else
                    scope.opened
                end
    respond_to do |format|
      format.html{@contacts = scope}
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    respond_to do |format|
      format.html{}
      format.js{
        @contact = @contact.dup
        @contact.user_id = User.current.id
        @contact.not_show_in_search = true

      }
    end
  end

  def remove
    @contact.status = params[:back] ? true : false
    @contact.save
    redirect_to contact_path(@contact)
  end

  # GET /contacts/new
  def new
    @contact = Contact.new(user_id: User.current.id)
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to edit_contact_url(@contact), notice: 'Contact was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to edit_contact_url(@contact), notice: 'Contact was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end


  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    respond_to do |format|
      format.html{}
      format.json{
        q = params[:q].to_s.downcase
        contacts = Contact.not_show_in_search.where('LOWER(first_name) LIKE ? ', "%#{q}%").
            or(Contact.not_show_in_search.where('LOWER(last_name) LIKE ? ', "%#{q}%")).
            or(Contact.not_show_in_search.where('LOWER(middle_name) LIKE ? ', "%#{q}%")).map{|contact| {id: contact.id, value: contact.name, label: contact.name}}.to_json
        render json: contacts
      }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
    add_breadcrumb @contact, @contact
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(Contact.safe_attributes)
  end

  def authorize_show
    raise Unauthorized unless @contact.can?(:view_contacts, :manage_contacts, :manage_roles)
  end

  def authorize_edit
    raise Unauthorized unless @contact.can?(:edit_contacts, :manage_contacts, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @contact.can?(:delete_contacts, :manage_contacts, :manage_roles)
  end
end
