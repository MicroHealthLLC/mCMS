module OrganizationConcern
  extend ActiveSupport::Concern

  included do
    def self.from_organization(options= {})
      return where(nil) if User.current.admin?
      org = User.current_user.organization
      extra_org = get_extra_organization options

      where(organization_id: [nil, org.try(:id), extra_org].flatten)
    end

    def self.get_extra_organization(options)
      extra_org = if options[:type] && options[:owner_id]
                    model_note = Note.new(type: options[:type], owner_id: options[:owner_id]).object
                    organizations = model_note.try(:organizations)
                    organizations ? organizations.compact.map(&:id) : nil
                  else
                    nil
                  end

      extra_org
    rescue StandardError
      nil
    end

  end
end
