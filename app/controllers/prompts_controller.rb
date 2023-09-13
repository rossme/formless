class PromptsController < ApplicationController
  before_action :set_user
  before_action :set_prompts

  def index; end

  def create
    service = PromptService::Request.new(user: @user, user_prompt: prompt_params[:input])
    raise StandardError, service.errors.full_messages.join(', ') unless service.valid? && service.call

    call_async_service(service)
  rescue StandardError => e
    flash[:alert] = e.message
  ensure
    redirect_to prompts_path
  end

  private

  def prompt_params
    params.require(:prompt).permit(:input)
  end

  def set_user
    @user = User.find_or_initialize_by(id: current_user)
  end

  def set_prompts
    @prompt = Prompt.new
    @prompts = current_user.prompts.limit(20).reverse_order
  end

  def call_async_service(service)
    ActionJob.perform_async(service.persisted_prompt.id)
    sleep(3) # temporary - wait for prompt to be created
  end
end
