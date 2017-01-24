class DocumentManagersController < ApplicationController

  before_filter :permitted_categories

  # Selection of categories the current user can view in the tree navigation
  def permitted_categories
    @permitted_categories = upload_permitted_categories
  end

  def index

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
      @document = @document.current_revision
      # Increment download count
      @document.increment!(:download_count)
      # Send file binary data to user's browser
      send_data(@document.file_data, :type => @document.file_type, :filename => @document.file_name, :disposition => "inline")
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
            file_data: revision_params.read,
            document_manager_id: @document.id,
            user_id: current_user.id,
            position: 0
          )
        if !@revision.save
          @document.destroy
          flash[:error] = "Unable to upload revision"
        else
          # Extract text from file to provide search engine with searchable content
          @revision.extract_text
          @revision.save
        end
      end
    end

    if !category.nil?
      redirect_to category_path(category, view_style: params[:view_style])
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
    redirect_to @category
  end

  private
    def document_params
      params.require(:document).permit(:title, :description, 
        :category_id, :is_writable, :is_private)
    end

    def revision_params
      params[:document][:revision][:file] if !params[:document][:revision].blank?
    end
end