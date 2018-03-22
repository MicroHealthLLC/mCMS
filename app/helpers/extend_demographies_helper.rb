module ExtendDemographiesHelper
  def url_back
    if @extend_demography.department_id
      departments_path
    elsif @extend_demography.contact_id
      contacts_url
    elsif @extend_demography.organization_id
      organizations_path
    elsif @extend_demography.affiliation_id
      affiliations_path
    elsif @extend_demography.insurance_id
      insurances_path
    elsif @extend_demography.case_support_id
      edit_case_support_path(@extend_demography.case_support_id)
    elsif User.current != User.current_user
      '/profile_record#tabs-extend_demographic'
    else
      if  User.current.can?(:manage_roles)
        if @user != User.current
          user_path(@user) + '#tabs-extend_demographic'
        else
          '/users/edit#tabs-extend_demographic'
        end
      else
        '/profile_record#tabs-extend_demographic'
      end
    end
  end

  def extend_demography_breadcrumb
    object = @extend_demography.object
    case @extend_demography.class.to_s
      when 'AffiliationExtendDemography'
        add_breadcrumb 'Client Profile', '/profile_record'
        add_breadcrumb I18n.t(:affiliations), :affiliations_path
      when 'CaseSupportExtendDemography'
        add_breadcrumb 'Case Records', :cases_path
        if object.case
          add_breadcrumb object.case, object.case
          add_breadcrumb I18n.t(:cases_supports), case_path(object.case) + "#tabs-case_supports"
        else
          add_breadcrumb I18n.t(:cases_supports), :case_supports_path
        end
      when 'ContactExtendDemography'
        add_breadcrumb 'Client Profile', '/profile_record'
        add_breadcrumb I18n.t(:contacts), :contacts_path
      when 'InsuranceExtendDemography'
        add_breadcrumb I18n.t(:insurances), :insurances_path
      when 'OrganizationExtendDemography'
        add_breadcrumb I18n.t(:organizations), :organizations_path
      when 'UserExtendDemography'
        if User.current.can?(:manage_roles)
          add_breadcrumb 'Users', '/users'
        else
          add_breadcrumb 'Client Profile', '/profile_record#tabs-extend_demographic'
        end
          else
        # nothing to do
    end
    if !User.current.can?(:manage_roles) and object.is_a? User
      add_breadcrumb object, '/profile_record#tabs-extend_demographic'
    else
      add_breadcrumb object, object
    end

  end
end
