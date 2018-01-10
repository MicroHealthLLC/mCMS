class PlanGoalWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(plan_id)
    plan = Plan.find(plan_id)
    plan.goals.each do |goal|
      goal.update_attributes percent_done: goal.plans.average(:percent_done).to_i
    end
  end
end
