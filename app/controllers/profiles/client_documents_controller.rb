class ClientDocumentsController <  ProtectForgeryApplication
  add_breadcrumb 'Client Profile', '/profile_record'
  add_breadcrumb I18n.t(:client_documents), '/profile_record#tabs-document'
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /documents
  # GET /documents.json
  def index
    @is_client_doc = true
    respond_to do |format|
      format.html{  redirect_to  User.current.can?(:manage_roles) ? edit_user_registration_path : profile_record_path + "#tabs-document" }
     format.js{ render 'application/index' }
      format.pdf{}
      format.csv{ params[:length] = 500
      options = Hash.new
      options[:status_type] = params[:status_type]
      options[:for] = 'profile'
      json = DocumentDatatable.new(view_context, options).as_json
      send_data Document.to_csv(json[:data]), filename: "Document-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        options[:for] = 'profile'
        render json: DocumentDatatable.new(view_context,options)
      }
    end
  end

  def show
    render 'documents/show'
  end

  # GET /documents/new
  def new
    @document = Document.new(user_id: User.current.id,
                             is_client_document: true)
    render 'documents/new'
  end

  # GET /documents/1/edit
  def edit
    render 'documents/edit'
  end

  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to back_url, notice: 'Document was successfully created.' }
      else
        format.html { render 'documents/new' }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to back_url, notice: 'Document was successfully updated.' }
      else
        format.html { 'documents/edit' }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to back_index_case_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
    add_breadcrumb @document, client_document_path(@document)
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def authorize
    super('documents', params[:action])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def document_params
    params.require(:document).permit(Document.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @document.can?(:edit_documents, :manage_documents, :manage_roles)
  end

  def back_url
      client_documents_url
  end
end
