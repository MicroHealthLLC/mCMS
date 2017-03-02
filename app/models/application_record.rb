class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  scope :visible, -> { where(user_id: User.current.id) }

  def can?(*args)
    User.current.admin? or (owner? and args.map{|action| User.current_user.allowed_to? action }.include?(true) )
  end

  def owner?
    self.try(:user) == User.current
  end

  # type should be [
  #    ["CaseStatusType", "case_status_type_id", {:is_closed=>true}], ...
  # ]

  # example:  Case.include_enumerations.join_enumeration(types)
  def self.join_enumeration(types = [])
    scope = self
    cond = ""
    cond_where = []
    cond_where2 = []
    types.each_with_index do |t, idx|
      enumeration_type = t[0]
      enumeration_column = t[1]
      hash = t[2]
      cond<< " LEFT JOIN enumerations e#{idx} ON #{self.table_name}.#{enumeration_column} = e#{idx}.id AND e#{idx}.type = '#{enumeration_type}' "
      if hash
        hash.each do |k, v|
          cond_where << "e#{idx}.#{k} = ? "
          cond_where2 << v
        end
      end
    end
    scope.joins(cond).where(cond_where.join(' AND '), cond_where2 )
  end

end
