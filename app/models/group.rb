class Group < ApplicationRecord

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :categories

  def to_s
    name
  end

  def leaders
    leader_members.to_a.map! {|member| member.user}
  end

  def leader_members
    Membership.where(group_id: id, level: Membership::LEVELS[:leader])
  end

  def members
    regular_members.to_a.map! {|member| member.user}
  end

  def regular_members
    Membership.where(group_id: id, level: Membership::LEVELS[:regular])
  end

  def leader_names
    names = Array.new
    leaders.each { |leader| names << leader.username }
    names.join(", ")
  end

  def member_names
    names = Array.new
    members.each { |member| names << member.username }
    names.join(", ")
  end

  def category_names
    names = Array.new
    categories.each { |cat| names << cat.name }
    names.join(", ")
  end

  def documents 
    documents = Array.new
    categories = Category.where(group_id: id)
    categories.each do |cat| 
      cat.document_managers.each do |doc|
        documents << doc
      end
    end
    documents
  end

end