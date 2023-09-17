# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :sign_in_fake_user # :authenticate_user!

  FAKE_USER_ID = 1

  private

  def sign_in_fake_user
    fake_user = User.find_by(id: FAKE_USER_ID)

    raise "Fake user with id #{FAKE_USER_ID} not found" unless fake_user

    sign_in fake_user
  end
end
