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
    # Check if the personal access token has expired, Octokit then raises an exception
    return I18n.t('application.release_details.error') unless latest_release && latest_deploy

    I18n.t('application.release_details.info', latest_release: latest_release, latest_deploy: latest_deploy)
  end

  def latest_release
    Octokit.latest_release('rossme/formless')&.tag_name
  rescue Octokit::Unauthorized
    nil # this error is handled in github_release_details
  end

  def latest_deploy
    Octokit.deployments('rossme/formless').first[:updated_at]
  rescue Octokit::Unauthorized
    nil # this error is handled in github_release_details
  end

  def remote_ip_address
    request.remote_ip
  end
end
