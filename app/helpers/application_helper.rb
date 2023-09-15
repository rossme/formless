# frozen_string_literal: true

module ApplicationHelper

  FLASH_LEVELS = {
    notice: 'info',
    success: 'success',
    error: 'danger',
    alert: 'warning'
  }.freeze

  def remote_ip_address
    request.remote_ip
  end

  def flash_class(level)
    FLASH_LEVELS[level.to_sym]
  end
end
