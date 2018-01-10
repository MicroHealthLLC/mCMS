class GoalNeedWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(id)
    goal = Goal.find(id)
    goal.needs.each do |need|
      need.update_attributes(percent_done: need.goals.average(:percent_done).to_i)
    end
  end
end
