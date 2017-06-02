class PlanGoalWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(plan_id)
    plan = Plan.find(plan_id)
    plan.goals.each do |goal|
      goal.percent_done = (goal.plans.average(:percent_done).to_i / 10).ceil * 10
      goal.save
    end
  end
end
