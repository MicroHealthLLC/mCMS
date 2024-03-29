class DocumentManagersController < ProtectForgeryApplication

  before_action  :authenticate_user!
  before_action  :authorize
  before_filter :permitted_categories, except: [:new_folder]

  # Selection of categories the current user can view in the tree navigation
  def permitted_categories
    @current_folder = DocumentFolder.new
    @permitted_categories = upload_permitted_categories
  end

  def index
    # Get all viewable categories
    @categories = Category.roots.reject { |c| !category_viewable?(c) and c.is_private }

    # Get featured categories and recently uploaded documents
    #  making sure to hide private docs and categories
    @featured = Category.featured
    @current_folder = Category.includes(:parent).where(id: params[:document_folder_id] ).first  || Category.new
    @latest_docs = DocumentManager.latest_docs @current_folder.id
    @sub_folders = Category.where(parent_id: @current_folder.id)
    show_breadcrumb
  end

  def show_breadcrumb
    categories = Array.new
    categories<< @current_folder if @current_folder.persisted?
    category = @current_folder
    while parent =  category.parent
      categories<< parent
      category = category.parent
    end

    add_breadcrumb "Documents", document_managers_path(document_folder_id: -1)
    categories.reverse.each do |c|
      add_breadcrumb c, document_managers_path(document_folder_id: c.id)
    end
  end

  def new_folder
    @folder = DocumentFolder.new(params.require(:document_folder).permit(:parent_id, :name))
    unless @folder.save
      flash[:error] = @folder.errors.full_messages.join('<br/>')
    end
    redirect_to document_managers_path
  end

  def show
    @document = DocumentManager.find_by_id(params[:id])

    if can_view_document(@document)
      @revisions = @document.revisions
      @category = Category.find(@document.category_id)
      @children_categories = @category.children
    else
      flash[:error] = "You do not have permission to view this document."
      redirect_to "/"
    end
  end

  def search
    # Use Sunspot Solr to search for documents based on the search query
    begin
      @documents = DocumentManager.search do
        fulltext params[:query], highlight: true
      end
    rescue
      @documents ||= nil
    end
  end

  def download
    @document = DocumentManager.find_by_id(params[:id])
    if !@document.nil?
      # Get the most recent revision when downloading a document
      @revision = @document.current_revision
      # Increment download count

      # Send file binary data to user's browser
      if @revision
        @revision.increment!(:download_count)
        if @revision.file_data
          send_data(@revision.file_data, :type => @revision.file_type, :filename => @revision.file_name, :disposition => "inline")
        else
          send_file "#{Rails.root}/public/#{@revision.dms_document.doc_url}"
        end
      else
        dms_document = @document.dms_documemnts.last
        if dms_document
          send_file "#{Rails.root}/public/#{dms_document.doc_url}"
        else
          render_404
        end
      end

    else
      flash[:error] = "Could not find requested document"
      redirect_to root_path
    end
  end

  def create
    if !revision_params.nil?
      # Create our new document
      @document = DocumentManager.new(document_params)
      @document.user_id = current_user.id

      category = Category.find_by_id(@document.category_id)
      if !@document.save
        flash[:error] = "Unable to upload document"
      else
        # Create the initial revision of the new document
        @revision = Revision.new(file_name: revision_params.original_filename,
                                 file_type: revision_params.content_type,
                                 # file_data: revision_params.read,
                                 document_manager_id: @document.id,
                                 user_id: current_user.id,
                                 position: 0
        )

        d = DmsDocumemnt.new(document_manager_id: @document.id)

        d.doc = params[:document][:revision][:file]
        if d.save
          if !@revision.save
            @document.destroy
            flash[:error] = "Unable to upload revision"
          else
            d.revision_id = @revision.id
            d.save
            # Extract text from file to provide search engine with searchable content
            @revision.extract_text
            @revision.save
          end
        else
          flash[:error] = d.errors.full_messages.join('<br/>').html_safe
          @document.destroy
        end


      end
    end

    if !category.nil?
      redirect_to @document.category ? document_managers_path(document_folder_id: @document.category_id ) : document_managers_path
    else
      redirect_to root_path
    end
  end

  def update
    @document = DocumentManager.find(params[:id])
    # Check if the current user is allowed to edit this document
    if !can_edit_document(@document)
      flash[:error] = "You are not allowed to edit this document."
      redirect_to "/"
    end
    # Check if document attributes have successfully saved
    if @document.update_attributes(document_params)
      flash[:success] = "DocumentManager updated!"
      redirect_to @document
    else
      flash[:error] = "DocumentManager failed to update: #{@document.errors.full_messages.to_sentence}"
      redirect_to @document
    end
  end

  def destroy
    @document = DocumentManager.find(params[:id])
    @category = @document.category
    @document.destroy
    redirect_to document_managers_url
  end

  private
  def document_params
    params.require(:document).permit(:title, :description, :folder_id,
                                     :category_id, :is_writable, :is_private)
  end

  def revision_params
    params[:document][:revision][:file] if !params[:document][:revision].blank?
  end
end
