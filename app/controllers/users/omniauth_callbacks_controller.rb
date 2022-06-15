# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    before_action :authorize_user

    def google_oauth2; end
    def github; end

    private

    def authorize_user
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: request.env['omniauth.auth'].provider
        sign_in_and_redirect @user, event: :authentication
      end
    end
  end
end
