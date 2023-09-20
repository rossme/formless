# frozen_string_literal: true

module ApplicationHelper

  FLASH_LEVELS = {
    notice: 'info',
    success: 'success',
    error: 'danger',
    alert: 'warning'
  }.freeze

  def latest_github_release
    Octokit.latest_release('rossme/formless')&.tag_name
  end

  def latest_deployed_release
    Octokit.deployments('rossme/formless').first[:updated_at]
  end

  def remote_ip_address
    request.remote_ip
  end

  def flash_class(level)
    FLASH_LEVELS[level&.to_sym].presence
  end
end
