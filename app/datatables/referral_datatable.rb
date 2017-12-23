class ReferralDatatable < AjaxDatatablesRails::Base

  def sortable_columns

    return @sortable_columns if @sortable_columns
    # Declare strings in this format: ModelName.column_name
    arr = []
    arr << ['Referral.title']
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end

    arr <<
        [ 'Enumeration.name',
          'Referral.referral_date',
          'Referral.referral_appointment',
          'Enumeration.name',
          'User.login',
          'Referral.referred_to_address'
        ]

    @sortable_columns = arr.flatten
  end

  def searchable_columns

    return @searchable_columns if @searchable_columns
    arr = []
    arr << ['Referral.title']
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end

    arr <<
        [ 'Enumeration.name',
          'Referral.referral_date',
          'Referral.referral_appointment',
          'Enumeration.name',
          'User.login',
          'Referral.referred_to_address'
        ]

    @searchable_columns = arr.flatten
  end

  private

  def data
    records.map do |referral|
      arr = Array.new

      arr << @view.link_to_edit_if_can(referral.title, {ctrl: :referrals, object: referral })
      if @options[:show_case] == 'true'
        arr << @view.link_to_case( referral.case)
      end
      arr<< [
          referral.referral_type.to_s ,
          @view.format_date( referral.referral_date.to_s) ,
          referral.referral_appointment.to_s ,
          referral.referral_status.to_s ,
          referral.referred_by.to_s,
          referral.referred_to_address.to_s
      ]
      if @options[:appointment_id] and User.current_user.can?(:manage_roles)
        arr<<  @view.link_to("<i class='fa fa-unlink fa-lg'></i>".html_safe, @view.unlink_appointment_path(appointment_id: @appointment.id, type: 'Referral', id: referral.id ))
      end
      arr.flatten
    end
  end

  def get_raw_records
    @appointment = Appointment.find @options[:appointment_id] if @options[:appointment_id]
    if @options[:appointment_id]
      @appointment_links = @appointment.appointment_links.includes(:linkable)
      Referral.include_enumerations.where(id: @appointment_links.where(linkable_type: 'Referral').map(&:linkable).map(&:id))
    else
      scope = if @options[:case_id]
                Case.find(@options[:case_id]).referrals.include_enumerations
              else
                Referral.include_enumerations
              end
      scope.for_status @options[:status_type]
    end
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
