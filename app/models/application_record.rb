class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  scope :visible, -> { where(user_id: User.current.id) }

  def can?(*args)
    owner? and args.map{|action| User.current_user.allowed_to? action }.include?(true)
  end

  def owner?
    self.try(:user) == User.current
  end

end
