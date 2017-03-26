# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  comment      :string
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  link_id      :integer
#  points_count :integer          default(0)
#  username     :string
#

class Comment < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  belongs_to :user
  belongs_to :link, counter_cache: true
  has_many :points

  validates_presence_of :comment
  validates_presence_of :link_id
  validates_presence_of :user_id

  def time_ago
    time_ago_in_words(self.created_at)
  end

  def as_json(options={})
    super(:methods => [:time_ago], except: [:created_at, :updated_at])
  end
end
