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

  scope :visible, -> { where(user_id: User.current.id) }

  def can?(*args)
    User.current.admin? or (owner? and args.map{|action| User.current_user.allowed_to? action }.include?(true) )
  end

  def owner?
    self.try(:user) == User.current
  end

  # def empty?
  #   new_record? ? false : true
  # end

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
end
