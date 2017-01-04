class ContactsController < ApplicationController
  before_action  :authenticate_user!
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  # before_action :find_optional_user
  before_action :authorize, only: [:new, :create]
  # before_action :authorize_show, only: [:show]
  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    respond_to do |format|
      format.html{@contacts = Contact.visible}
      format.json{
        q = params[:q].to_s.downcase
        contacts = Contact.not_show_in_search.where('LOWER(first_name) LIKE ? ', "%#{q}%").
            or(Contact.not_show_in_search.where('LOWER(last_name) LIKE ? ', "%#{q}%")).
            or(Contact.not_show_in_search.where('LOWER(middle_name) LIKE ? ', "%#{q}%")).map{|contact| {id: contact.id, value: contact.name, label: contact.name}}.to_json
        render json: contacts
      }
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

  # GET /contacts/new
  def new
    @contact = Contact.new(user_id: @user.id)
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

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
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
