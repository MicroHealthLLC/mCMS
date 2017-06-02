class GoalNeedWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(id)
    goal = Goal.find(id)
    goal.needs.each do |need|
      need.percent_done = (need.goals.average(:percent_done).to_i / 10).ceil * 10
      need.save
    end
  end
end
