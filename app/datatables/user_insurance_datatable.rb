class UserInsuranceDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Enumeration.name
      Enumeration.name
      Enumeration.name
      UserInsurance.insurance_identifier
      UserInsurance.issue_date
      UserInsurance.expiration_date
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Enumeration.name
      Enumeration.name
      Enumeration.name
      UserInsurance.insurance_identifier
      UserInsurance.issue_date
      UserInsurance.expiration_date
    }
  end

  private

  def data
    records.map do |user_insurance|
      [
          @view.link_to_edit_if_can( user_insurance.insurance_type, {ctrl: :user_insurances, object: user_insurance }) ,
          user_insurance.insurance_type.to_s ,
          user_insurance.insurance_status.to_s ,
          user_insurance.insurance_identifier ,
          @view.format_date( user_insurance.issue_date) ,
          @view.format_date( user_insurance.expiration_date)
      ]



    end
  end

  def get_raw_records
    scope = UserInsurance.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
