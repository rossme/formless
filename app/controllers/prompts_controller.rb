class PromptsController < ApplicationController
  before_action :set_user, :set_prompts
  before_action :set_text, :call_prompt_service, only: %i[create]

  def new; end

  def create
    response = @service.call
    raise StandardError, response.errors.full_messages.join(', ') unless response.valid?

    respond_to do |format|
      format.html { redirect_to new_prompt_url, notice: 'The prompt response was successfully created.' }
    end
  rescue => e
    redirect_to new_prompt_url, alert: e
  end

  def strong_params
    params.require(:prompt).permit(:text)
  end

  def call_prompt_service
    @service ||= PromptService::Request.new(user: @user, prompt: @text)
    raise StandardError, @service.errors.full_messages.join(', ') unless @service.valid?
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
