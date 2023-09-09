class PromptsController < ApplicationController
  before_action :set_user, :set_prompts
  before_action :set_text, :call_prompt_service, only: %i[create]

  def new; end

  def create
    raise PromptError, response.errors.full_messages.join(', ') unless @service.valid?

    # Handle the prompt action worker in the background
    ActionJob.perform_async(@service.prompt.id)

    redirect_to prompts_url, flash: { success: 'Response created' }
  rescue PromptError, StandardError => e
    redirect_to new_prompt_url, alert: e
  end

  def strong_params
    params.require(:prompt).permit(:text)
  end

  def call_prompt_service
    @service ||= PromptService::Request.new(user: @user, prompt: @text)
    raise PromptError, @service.errors.full_messages.join(', ') unless @service.valid?

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
end
