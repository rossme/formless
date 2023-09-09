class PromptsController < ApplicationController
  before_action :set_user, :set_prompts
  before_action :set_text, :call_prompt_service, only: %i[create]

  def new; end

  def create
    raise PromptError, response.errors.full_messages.join(', ') unless @service.valid?

    # PromptService::HandleAction.new(user: @user, prompt: @text, ai_response: @service.response).call

    redirect_to new_prompt_url flash: { success: 'Response created' }
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
