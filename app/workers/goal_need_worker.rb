class GoalNeedWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(id)
    goal = Goal.find(id)
    goal.needs.each do |need|
      need.percent_done = need.goals.average(:percent_done).to_i
      need.save
    end
  end
end
