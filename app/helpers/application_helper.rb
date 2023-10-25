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
    return I18n.t('application.release_details.error') unless octokit_request

    I18n.t('application.release_details.info',
           latest_release: octokit_request[:latest_release],
           latest_deploy: octokit_request[:latest_deploy]
    )
  end

  def remote_ip_address
    request.remote_ip
  end

  # `rails dev:cache` toggles caching in development environment
  def octokit_request
    @octokit_request ||= Rails.cache.fetch('octokit_request', expires_in: 12.hours) do
      Rails.logger.info(I18n.t('application.release_details.caching'))
      {
        latest_release: Octokit.latest_release('rossme/formless')&.tag_name,
        latest_deploy: Octokit.deployments('rossme/formless').first[:updated_at]
      }
    end
  rescue Octokit::Unauthorized, Octokit::TooManyRequests
    nil # this error is handled in github_release_details
  end
end
