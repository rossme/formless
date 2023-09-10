class PromptsController < ApplicationController
  before_action :set_user, :set_prompts
  before_action :set_text, :call_prompt_service, only: %i[create]
  before_action :set_action_prompts, only: %i[index]

  def index; end

  def create
    raise PromptError, response.errors.full_messages.join(', ') unless @service.valid?

    ActionJob.perform_async(@service.persisted_prompt.id)
    redirect_to prompts_url, flash: { success: 'Response created' }
  rescue PromptService::PromptError, StandardError => e
    redirect_to prompts_url, alert: e
  end

  def strong_params
    params.require(:prompt).permit(:text)
  end

  def call_prompt_service
    @service ||= PromptService::Request.new(user: @user, user_prompt: @text)
    raise PromptService::PromptError, @service.errors.full_messages.join(', ') unless @service.valid?

    @service.call
  end

  def set_user
    @user = User.find_or_initialize_by(id: current_user)
  end

  def set_prompts
    @prompts = current_user.prompts.reverse_order
  end

  def set_text
    @text = strong_params[:text]
  end

  def set_action_prompts
    @action_prompts = current_user.prompts.where(actioned: true).reverse_order
  end
end
