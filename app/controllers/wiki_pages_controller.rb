class WikiPagesController < ProtectForgeryApplication
  acts_as_wiki_pages_controller

  def new_page_title
    if request.post?
      p = params[:wiki_page][:title]
      wiki_page = WikiPage.where(title: p).first
      if wiki_page.nil?
        redirect_to "/wiki/new/#{p}"
      else
        flash[:error] = "Page already exist"
      end
    end
  end

  def all
    @pages = WikiPage.where(sub_page_id: [nil, 0]).paginate(page: params[:page], per_page: 15) # Loading and paginating all pages

    render_template 'all'
  end

  def new
    return not_allowed unless show_allowed? && edit_allowed?
    @page = WikiPage.new
    render_template 'new'
  end

  def update
    if params[:new_record] == 'true'
      @page = WikiPage.new
    end
    return not_allowed unless params[:page] && (@page.new_record? || edit_allowed?) # Check for rights (but not for new record, for it we will use second check only)

    @page.attributes = permitted_page_params

    return not_allowed unless edit_allowed? # Double check: used beacause action may become invalid after attributes update

    @page.path = @page.title.parameterize if params[:new_record] == 'true'
    if @page.path.to_s.downcase.in?(['new', 'destroy', 'index', 'show', 'update'])
      @page.path = @page.path.to_s + '1'
      while WikiPage.where(path: @page.path.to_s).present?
        @page.path.succ!
      end
    end



    @page.updator = @current_user # Assing user, which updated page
    @page.creator = @current_user if @page.new_record? # Assign it's creator if it's new page

    if !params[:preview] && (params[:cancel] || @page.save)
      redirect_to url_for(action: :show, path: @page.path.split('/')) # redirect to new page's path (if it changed)
    else
      if params[:new_record] == 'true'
        render_template 'new'
      else
        render_template 'edit'
      end

    end
  end

  def destroy
    return not_allowed unless destroy_allowed?

    @page.destroy

    redirect_to url_for(action: :all)
  end

  # Check is it allowed for current user to see current page. Designed to be redefined by application programmer
  def show_allowed?
    User.current.can?(:manage_wikis, :manage_roles)
  end

  # Check is it allowed for current user see current page history. Designed to be redefined by application programmer
  def history_allowed?
    User.current.can?(:manage_wikis, :manage_roles)
  end

  # Check is it allowed for current user edit current page. Designed to be redefined by application programmer
  def edit_allowed?
    User.current.can?(:manage_wikis, :manage_roles)
  end

  # Check is it allowed for current user destroy current page. Designed to be redefined by application programmer
  def destroy_allowed?
    User.current.can?(:manage_wikis, :manages_roles)
  end

  def permitted_page_params
    params.require(:page).permit(:title, :content, :sub_page_id,
                                 :comment,
                                 wiki_page_attachments_attributes: [Attachment.safe_attributes])
  end

end
