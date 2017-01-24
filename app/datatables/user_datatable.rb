class UserDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      User.id
      User.login
      User.email
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      User.id
      User.login
      User.email
    }
  end

  private

  def data
    records.map do |user|
      [
          user.id ,
          user.login,
          user.email,
          user.deleted? ? '<i class="fa fa-eye-slash" aria-hidden="true"></i>' : @view.show_link(user) ,
          user.deleted? ?   @view.restore_user_link(user) :  @view.delete_link(user)
      ]
    end
  end

  def get_raw_records
    User.unscoped
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
