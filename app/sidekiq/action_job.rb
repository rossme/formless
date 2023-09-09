class ActionJob
  include Sidekiq::Job

  def perform(prompt_id)
    ActionService::ActionCreator.new(prompt_id: prompt_id).call
  end
end
