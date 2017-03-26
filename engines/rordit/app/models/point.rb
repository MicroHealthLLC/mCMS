# == Schema Information
#
# Table name: points
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  link_id    :integer
#  comment_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Point < ActiveRecord::Base
  belongs_to :user
  belongs_to :link, counter_cache: true
  belongs_to :comment, counter_cache: true

  validates_presence_of :user_id
end
