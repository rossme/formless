# frozen_string_literal: true

module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      # As part of the formless PoC we are using a fake user with id 1
      user = FactoryBot.create(:user, id: 1)
      sign_in user
    end
  end
end
