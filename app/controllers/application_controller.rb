class ApplicationController < ActionController::Base
  before_action :sign_in_fake_user # :authenticate_user!

  FAKE_USER_ID = 1

  private

  def sign_in_fake_user
    sign_in User.find_by(id: FAKE_USER_ID)
  end
end
