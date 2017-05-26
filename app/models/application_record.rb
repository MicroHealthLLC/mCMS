class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  belongs_to :updated_by, optional: true, class_name: 'User'
  belongs_to :created_by, optional: true, class_name: 'User'

  before_save do
    self.updated_by_id = User.current_user.id if self.class.column_names.include?('updated_by_id')
  end

  before_create do
    self.created_by_id = User.current_user.id if self.class.column_names.include?('created_by_id')
  end

  after_create do
    EmailWorker.perform_in(1.second, self.class.to_s, self.id)
  end

  after_update do
    if self.class.to_s != 'User'
      EmailUpdateWorker.perform_async(self.class.to_s, self.id)
      EmailWatcherWorker.perform_async( self.class.to_s, self.id)
    end
  end


  def email_notification_enabled?(type)
    notif = EmailNotification.find_by(email_type: type, name: "#{self.class}") || EmailNotification.new(status: false)
    notif.enabled?
  end

  def little_description
    output = ''
    output<< "<p> #{} </p>"
    output<< "<p> #{} </p>"
    output<< "<p> #{} </p>"

    output.html_safe
  end


  scope :visible, -> { where(user_id: User.current.id) }

  def self.for_status(status)
    scope =  self.visible
    scope = case status
              when 'all' then scope.all_data
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.all_data
            end
    scope
  end

  def can?(*args)
    User.current_user.admin? or User.current_user.can?(:manage_roles) or (owner? and args.map{|action| User.current.allowed_to? action }.include?(true) )
  end

  def owner?
    self.try(:user) == User.current
  end

  def humanize_value object, key, value
    if ['note', 'description'].include?(key)
      value.html_safe
    elsif key[-3..-1] == '_id'
      object.send(key[0..-4])
    else
      value
    end
  end

  # example:  Case.include_enumerations.join_enumeration(types)
  def self.join_enumeration(types, status, type = ' OR ')
    scope = self
    cond = ""
    cond_where = []
    cond_where2 = []
    types.each_with_index do |t, idx|
      enumeration_type = t[0]
      enumeration_column = t[1]
      cond<< " LEFT JOIN enumerations e#{idx} ON #{self.table_name}.#{enumeration_column} = e#{idx}.id AND e#{idx}.type = '#{enumeration_type}' "

      status.each do |k, v|
        cond_where << "e#{idx}.#{k} = ? "
        cond_where2 << v
      end
    end
    scope.joins(cond).where(cond_where.join(type), *cond_where2 )
  end

  def self.enumeration_columns
    fail(
        MethodNotImplementedError,
        'Please implement this method in your class.'
    )
  end

  def self.all_data
    where.not(id: closed.pluck(:id))
  end

  def self.opened
    # join_enumeration(enumeration_columns, { is_closed: false, is_flagged: false}, ' AND ', '!=')
    where.not(id: closed_or_flagged.pluck(:id))
  end

  def self.closed
    join_enumeration(enumeration_columns, { is_closed: true})
  end

  def self.flagged
    join_enumeration(enumeration_columns, { is_flagged: true})
  end

  def self.closed_or_flagged
    join_enumeration(enumeration_columns, { is_closed: true, is_flagged: true})
  end

  def can_send_email?
    false
  end
end
