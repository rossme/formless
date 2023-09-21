# frozen_string_literal: true

module ApplicationHelper

  FLASH_LEVELS = {
    notice: 'info',
    success: 'success',
    error: 'danger',
    alert: 'warning'
  }.freeze

  def flash_class(level)
    FLASH_LEVELS[level&.to_sym].presence
  end

  def github_release_details
    raise StandardError, I18n.t('application.release_details.error') unless latest_release && latest_deploy

    I18n.t('application.release_details.info', latest_release: latest_release, latest_deploy: latest_deploy)
  end

  def latest_release
    Octokit.latest_release('rossme/formless')&.tag_name
  end

  def latest_deploy
    Octokit.deployments('rossme/formless').first[:updated_at]
  end

  def remote_ip_address
    request.remote_ip
  end
end
