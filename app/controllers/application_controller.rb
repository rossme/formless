# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :sign_in_fake_user # :authenticate_user!

  def sign_in_fake_user
    fake_user = User.last
    raise 'There are no Users available' unless fake_user

    sign_in fake_user
  end
end
