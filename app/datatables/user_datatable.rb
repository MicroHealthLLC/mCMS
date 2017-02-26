class UserDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      User.id
      User.login
      User.email
      CoreDemographic.first_name
      CoreDemographic.middle_name
      CoreDemographic.last_name
      CoreDemographic.birth_date
      Role.name
      Enumeration.name
      User.state
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      User.id
      User.login
      User.email
      CoreDemographic.first_name
      CoreDemographic.middle_name
      CoreDemographic.last_name
      CoreDemographic.birth_date
      Role.name
      Enumeration.name
      User.state
    }
  end

  private

  def data
    records.map do |user|
      [
          user.id ,
          user.login,
          user.email,
          user.first_name,
          user.middle_name,
          user.last_name,
          user.birthday,
          user.role.to_s,
          user.gender.to_s,
          user.state,

          user.deleted? ? '<i class="fa fa-eye-slash" aria-hidden="true" ></i>' : @view.show_link(user, 'data-turbolinks'=> false) ,
          user.deleted? ?   @view.restore_user_link(user, 'data-turbolinks'=> false) :  @view.delete_link(user, 'data-turbolinks'=> false),
          user.locked_at? ?   @view.unlock_user_link(user, 'data-turbolinks'=> false) :  @view.lock_user_link(user, 'data-turbolinks'=> false)
      ]
    end
  end

  def get_raw_records
    User.unscoped.include_enumerations
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
