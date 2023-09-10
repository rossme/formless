class ActionJob
  include Sidekiq::Job

  def perform(persisted_prompt_id)
    ActionService::ActionCreator.new(persisted_prompt_id: persisted_prompt_id).call
  end
end
