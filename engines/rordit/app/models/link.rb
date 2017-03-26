# == Schema Information
#
# Table name: links
#
#  id             :integer          not null, primary key
#  title          :string
#  url            :string
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  popularity     :float            default(0.0)
#  hostname       :string
#  comments_count :integer          default(0)
#  points_count   :integer          default(0)
#  username       :string
#

# require 'elasticsearch/model'

class Link < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks

  # include Paginate

  belongs_to :user, touch: true
  has_many :points
  has_many :comments

  validates_presence_of :title
  validates :url, presence: true, uniqueness: true
  validates_presence_of :user_id
  validates_presence_of :hostname

  def self.calculate_last_200_popularity
    last_200_links = Link.last(200)
    last_200_links.each do |link|
      link.calculate_popularity
    end
  end

  def calculate_popularity
    hours = (Time.now - self.created_at) / 1.hour
    popularity =  (self.points_count - 1) / (hours ** 1.8)
    self.update(popularity: popularity)
  end

  def time_ago
    time_ago_in_words(self.created_at)
  end

  def as_json(options={})
    super(:methods => [:time_ago], except: [:updated_at])
  end
end