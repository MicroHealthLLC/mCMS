module DmsfHelper
  # ====================
  # Permission Helpers 
  # ====================

  # Check if the current logged in user is an admin
  def admin?
    User.current.admin? 
  end

  # ====================
  # Category Permissions
  # ====================

  # Check if the current user can upload documents to the specified category
  def can_upload_documents(category)
    if !User.current.nil?
      if category.nil?
        # User will specify category upon uploading
        return true
      elsif category.is_writable or User.current.member_of(category.group_id)
        # Category can be submitted to or user is part of controlling group
        return true
      else
        return false
      end
    else
      return false
    end
  end

  # Check if the current user can view the current category
  def category_viewable?(category)
    # Check if user is able to view a specific category
    if !User.current.nil?
      if User.current.admin? or User.current.member_of(category.group_id)
        return true
      else
        return false
      end
    else
      return false
    end
  end

  # Check if the current user can upload documents to the specified category
  def upload_permitted_categories
    # Return all categories the current user can upload to
    return nil if User.current.nil?
    permitted_categories = Category.all if User.current.admin?
    permitted_categories ||= User.current.writable_categories
  end

  # ====================
  # Document Permissions
  # ====================


  # Check if the current user can revise a specific document
  def can_revise_document(document)
    # deny user if not logged in
    return false if User.current.nil?
    # current user is an admin
    return true if User.current.admin?
    # current user is a member of the category's
    #   group for a document that is write protected
    unless document.category.group.nil?
      return true if !document.is_writable? and 
                     (document.category.group.members.include?(User.current) or
                      document.category.group.leaders.include?(User.current))
    end
    return document.is_writable?
  end

  # Check if the current user can view a specific document
  def can_view_document(document)
    # allow access if user is logged in
    return true if !User.current.nil? and User.current.admin?
    # current user is a member of the category's
    #   group for a document that is private
    unless document.category.group.nil?
      return true if document.is_private? and 
                    (document.category.group.members.include?(User.current) or
                     document.category.group.leaders.include?(User.current))
    end
   !document.is_private?
  end

  # Check if the current user can edit a specific document
  def can_edit_document(document)
    # deny user if not logged in
    return false if User.current.nil?
    # current user is an admin
    return true if User.current.admin?
    # current user is a member of the category's group
    unless document.category.group.nil?
      return true if document.category.group.members.include?(User.current) or 
                     document.category.group.leaders.include?(User.current)
    end
    false
  end

end