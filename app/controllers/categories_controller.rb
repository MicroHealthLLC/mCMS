class CategoriesController < ProtectForgeryApplication

  before_action  :authenticate_user!
  before_filter :set_category, only: [:edit, :update, :destroy, :show]
  before_filter :require_admin, except: [:index, :show]

  before_filter :permitted_categories

  # Selection of categories the current user can view in the tree navigation
  def permitted_categories
    @permitted_categories = upload_permitted_categories
  end

  # GET /categories
  def index
    # Get all viewable categories
    @categories = Category.roots.reject { |c| !category_viewable?(c) and c.is_private }

    # Get featured categories and recently uploaded documents
    #  making sure to hide private docs and categories
    @featured = Category.featured
  end

  # GET /categories/:id
  def show
    # Get category and its subcategories

    @categories = @category.children

    # Check if category is restricted to group members only
    if @category.is_private
      if !category_viewable?(@category)
        flash[:error] = "Sorry, you are unauthorized to access this category."
        redirect_to "/"
      end
    end

    # Get all documents associated with this category
    @documents = DocumentManager.where(category_id: @category.id).order("updated_at desc").page(params[:page])

    # Check if a view style (list or grid) is specified
    if params.key?(:view_style)
      @view_style = params[:view_style]
    else
      # Default to list view
      @view_style = "grid"
    end

    respond_to do |format|
      format.html {}
    end
  end

  def new
    @category = Category.new
    # Get categories and groups for selection dropdowns
    @categories = Category.all.map {|cat| [cat.name, cat.id]}
    @groups = Group.all.map {|group| [group.name, group.id]}
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      flash[:error] = "Unable to save category: #{@category.errors.full_messages.to_sentence}"
      redirect_to "/"
    end
  end

  def edit
    # Get categories and groups for selection dropdowns
    @categories = Category.all.map {|cat| [cat.name, cat.id]}
    @categories.delete([@category.name, @category.id])
    @groups = Group.all.map {|group| [group.name, group.id]}
  end

  def update
    @category.update_attributes(category_params)
    redirect_to categories_path(@category)
  end

  def destroy
  #  if @category.children.present || @category.document_managers.present ?
  #    flash[:error] = 'This category is linked and could not be deleted'
  #    redirect_to categories_path(@category)
  #  else    
      @category.destroy
      redirect_to categories_path
  #  end
  end

  def manage
    @categories = Category.all
  end

  def subcategories
    @subcategories = Category.find(params[:id]).children.map{ |c| c.subcategories_json}

    render json: @subcategories
  end

  private

  def set_category
    @category = Category.find_by_id(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def category_params
    params.require(:category).permit(:name, :description,
                                     :group_id, :parent_id, :is_featured, :is_private, :is_writable)
  end
end
