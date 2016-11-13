class WikiPagesController < ApplicationController
  acts_as_wiki_pages_controller

  # Check is it allowed for current user to see current page. Designed to be redefined by application programmer
  def show_allowed?
    true
  end

  # Check is it allowed for current user see current page history. Designed to be redefined by application programmer
  def history_allowed?
    User.current.admin?
  end

  # Check is it allowed for current user edit current page. Designed to be redefined by application programmer
  def edit_allowed?
    User.current.admin?
  end

  # Check is it allowed for current user destroy current page. Designed to be redefined by application programmer
  def destroy_allowed?
    edit_allowed?
  end

  def permitted_page_params
    params.require(:page).permit(:title, :content, :comment, wiki_page_attachments_attributes: [Attachment.safe_attributes])
  end

end
