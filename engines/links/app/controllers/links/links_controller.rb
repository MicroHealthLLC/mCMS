module Links
  class LinksController < UserProfilesController
    before_action :set_link, only: [:show, :edit, :update, :destroy]

    before_action :authorize_edit, only: [:edit, :update]
    before_action :authorize_delete, only: [:destroy]


    # GET /links
    def index
      @links = Link.visible
    end

    # GET /links/1
    def show
    end

    # GET /links/new
    def new
      @link = Link.new(user_id: User.current.id)
    end

    # GET /links/1/edit
    def edit
    end

    # POST /links
    def create
      @link = Link.new(link_params)

      if @link.save
        redirect_to @link, notice: 'Link was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /links/1
    def update
      if @link.update(link_params)
        redirect_to @link, notice: 'Link was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /links/1
    def destroy
      @link.destroy
      redirect_to links_url, notice: 'Link was successfully destroyed.'
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    # Only allow a trusted parameter "white list" through.
    def link_params
      params.require(:link).permit(:title, :url, :user_id)
    end

    def authorize_edit
      raise Unauthorized unless @link.can?(:manage_links, :manage_roles)
    end

    def authorize_delete
      raise Unauthorized unless @link.can?(:manage_links, :manage_roles)
    end
  end
end
